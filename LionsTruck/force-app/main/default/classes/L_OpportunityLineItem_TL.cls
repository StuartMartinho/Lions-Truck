public without sharing class L_OpportunityLineItem_TL {
    
    public static void calculateOpportunityParentCounters(List<OpportunityLineItem> oppLIlist) {
        
        Set<Id> parentOppIDs = getOpportunityParentIds(oppLIlist);
		Map<Id, Opportunity> opportunitiesMap = L_QueryHandler.getOpportunitiesMapById(parentOppIDs);
        Map<Id, List<OpportunityLineItem>> oppLIPerOpportunityIdMap = L_QueryHandler.getOppLIPerOpportunityParentId(parentOppIDs);
        
        Decimal trucksCounter = 0;
        Decimal servicesCounter = 0;
        
        for(Id oppId : oppLIPerOpportunityIdMap.keySet()){
            trucksCounter = 0;
        	servicesCounter = 0;
            for(OpportunityLineItem oppLIObj : oppLIPerOpportunityIdMap.get(oppId)){
                trucksCounter += oppLIObj.Quantity;
                if(oppLIObj.L_AddedService__c){
                   servicesCounter += oppLIObj.Quantity; 
                }
            }
            
            opportunitiesMap.get(oppId).L_TrucksQuantity__c = trucksCounter;
            opportunitiesMap.get(oppId).L_ServicesQuantity__c = servicesCounter;
        }
        
        update opportunitiesMap.values();        
    }
    
    
    private static Set<Id> getOpportunityParentIds(List<OpportunityLineItem> oppLIlist) {
        
        Set<Id> oppSetIds = new Set<Id>();
        
        for(OpportunityLineItem oppLIObj : oppLIlist){
            oppSetIds.add(oppLIObj.OpportunityId);
        }
        
        return oppSetIds;
    }
    
}