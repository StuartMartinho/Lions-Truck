public inherited sharing class L_QueryHandler {
    
    public static Map<Id, List<OpportunityLineItem>> getOppLIPerOpportunityParentId(Set<Id> oppIds){
        
        List<OpportunityLineItem> oppLIsFromDB = new List<OpportunityLineItem>();
        Map<Id, List<OpportunityLineItem>> oppLIsPerOppIdMap = new Map<Id, List<OpportunityLineItem>>();
        try{
            oppLIsFromDB = [select id, Quantity, L_AddedService__c, OpportunityId, TotalPrice, Product2Id, UnitPrice, Opportunity.AccountId 
                            FROM OpportunityLineItem WHERE OpportunityId IN :oppIds];
            
            for(OpportunityLineItem oppLIObj : oppLIsFromDB){
                if(oppLIsPerOppIdMap.containsKey(oppLIObj.OpportunityId)){
                    oppLIsPerOppIdMap.get(oppLIObj.OpportunityId).add(oppLIObj);
                }else{
                    oppLIsPerOppIdMap.put(oppLIObj.OpportunityId, new List<OpportunityLineItem>{oppLIObj});
                }
            }
            
        }catch(Exception ex){
            throw ex;
        }
        return oppLIsPerOppIdMap;
    }
    
    public static Map<Id, Opportunity> getOpportunitiesMapById(Set<Id> oppIds){
        
        Map<Id, Opportunity> mapToReturn;
        try{
            mapToReturn = new Map<Id, Opportunity>([SELECT Id, L_TrucksQuantity__c, L_ServicesQuantity__c FROM Opportunity WHERE ID IN :oppIds]);            
        }catch(Exception ex){
            throw ex;
        }
        return mapToReturn;
    }
    
    public static List<OpportunityLineItem> getOppLIByOppIdList(Set<Id> oppIds){
        List<OpportunityLineItem> listToReturn; 
        try{
            listToReturn = [SELECT Id, Product2Id, Quantity, TotalPrice, L_AddedService__c, OpportunityId, UnitPrice, Opportunity.AccountId,
                            Product2.L_Tonnage__c, Product2.L_PS__c, Product2.Name
                            FROM OpportunityLineItem WHERE OpportunityId IN :oppIds];            
        }catch(Exception ex){
            throw ex;
        }
        return listToReturn;
    }
    
    public static List<OpportunityLineItem> getOppLIList(Set<Id> oppLiIds){
        List<OpportunityLineItem> listToReturn; 
        try{
            listToReturn = [SELECT Id, Product2Id, Quantity, TotalPrice, L_AddedService__c FROM OpportunityLineItem WHERE ID IN :oppLiIds];            
        }catch(Exception ex){
            throw ex;
        }
        return listToReturn;
    }
    
    public static List<PricebookEntry> getPricebookEntriesFromPricebookId(List<Id> pbIds){
        List<PricebookEntry> listToReturn; 
        try{
            listToReturn = [SELECT Id, Product2Id, Pricebook2Id FROM PricebookEntry WHERE Pricebook2Id IN :pbIds];            
        }catch(Exception ex){
            throw ex;
        }
        return listToReturn;
    }
    
    public static Map<id, List<Order>> getOrdersByOpportunityIdMap(Set<Id> oppIds){
        Map<id, List<Order>> mapToReturn = new Map<id, List<Order>>(); 
        try{
            List<Order> orderList = [SELECT Id, Status, OpportunityId FROM Order WHERE OpportunityId IN :oppIds];
            for(Order orderObj : orderList){
                system.debug('orderObj->'+orderObj);
                if(mapToReturn.containsKey(orderObj.OpportunityId)){
                    mapToReturn.get(orderObj.OpportunityId).add(orderObj);
                }else{
                    mapToReturn.put(orderObj.OpportunityId, new List<Order>{orderObj});
                }
            }
        }catch(Exception ex){
            throw ex;
        }
        return mapToReturn;
    }
    
    public static List<Asset> getAssetsByAccountIds(Set<Id> accountIds){
        List<Asset> assetList = new List<Asset>();
        
        try{
            assetList = [SELECT Id, Name FROM Asset WHERE AccountId IN :accountIds];
        }catch(Exception ex){
            throw ex;
        }
        
        return assetList;
    }
    
    public static List<Asset> getAssetsWithVINByIds(Set<Id> ids){
        List<Asset> assetList = new List<Asset>();
        
        try{
            assetList = [SELECT Id, Name, L_VIN__c FROM Asset WHERE Id IN :ids AND L_VIN__c != ''];
        }catch(Exception ex){
            throw ex;
        }
        
        return assetList;
    }
    
    public static List<L_CalloutMappingCMDT__mdt> getCalloutMapping(String objectName){
        
        List<L_CalloutMappingCMDT__mdt> listToReturn = new List<L_CalloutMappingCMDT__mdt>();
        
        try{
            listToReturn = [SELECT Id, Label, QualifiedApiName, L_JSONAttributeName__c, L_FieldAPIName__c, L_SObjectName__c FROM L_CalloutMappingCMDT__mdt WHERE L_SObjectName__c = :objectName];
        }catch(Exception ex){
            throw ex;
        }
        
        return listToReturn;
            
    }

}