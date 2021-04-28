public inherited sharing class L_QueryHandler {
    
    public static Map<Id, List<OpportunityLineItem>> getOppLIPerOpportunityParentId(Set<Id> oppIds){
        
        List<OpportunityLineItem> oppLIsFromDB = new List<OpportunityLineItem>();
        Map<Id, List<OpportunityLineItem>> oppLIsPerOppIdMap = new Map<Id, List<OpportunityLineItem>>();
        try{
            oppLIsFromDB = [select id, Quantity, L_AddedService__c, OpportunityId, TotalPrice from OpportunityLineItem where OpportunityId IN :oppIds];
            
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

}