public without sharing class L_Opportunity_TL {


    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used create a new Assets whenever a Opportuny is set as Closed Won
    **************************************************************************************************/
    public static void processClosedWonOpportunities(Map<Id, Opportunity> oppMap){
        
        if(oppMap.IsEmpty()){
            return;
        }
        
        List<Asset> assetsToCreate = new List<Asset>();
        List<OpportunityLineItem> oppLIsList = L_QueryHandler.getOppLIByOppIdList(oppMap.keyset());
        
        for(OpportunityLineItem oppLIObj : oppLIsList){
            createAsset(oppLIObj, assetsToCreate);
        }    
        
        insert assetsToCreate;
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to populate an Asset list, depending on the provided Opportinity Li obj data
    **************************************************************************************************/
    private static void createAsset(OpportunityLineItem oppLIObj, List<Asset> assetsToCreate){        
        for (Integer i = 0; i < oppLIObj.Quantity; i++) {
            assetsToCreate.add(new Asset(Name=oppLIObj.Product2.Name, AccountId=oppLIObj.Opportunity.AccountId, Product2Id=oppLIObj.Product2Id,
                                         L_PS__c=oppLIObj.Product2.L_PS__c, L_Tonnage__c=oppLIObj.Product2.L_Tonnage__c, PurchaseDate=System.Today(),
                                         L_InitialService__c=oppLIObj.L_AddedService__c, SerialNumber=L_GuidUtility.newGuid()));
        }
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To filter only the opportunities that were set to Close Won status
    **************************************************************************************************/
    public static Map<Id, Opportunity> filterClosedWonOpps(Map<Id, Opportunity> oldOppMap, Map<Id, Opportunity> newOppMap){
        Map<Id, Opportunity> mapToReturn = new Map<Id, Opportunity>();
        for(Opportunity oppObj : newOppMap.values()){
            
            if(oldOppMap.get(oppObj.id).StageName != oppObj.StageName && oppObj.StageName.equalsIgnoreCase(L_Constants.OPP_CLOSED_STATUS)){
                mapToReturn.put(oppObj.id, oppObj);
            }
        }
        
        return mapToReturn;
    }
}