public without sharing class L_OpportunityLineItem_TL {
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to recalculate the Opportunity Parent quantities and values,
     whenever a new Opportunity LI is created/updated.
    **************************************************************************************************/
    public static void calculateOpportunityParentCounters(List<OpportunityLineItem> oppLIlist) {
        
        Set<Id> parentOppIDs = getOpportunityParentIds(oppLIlist);
		Map<Id, Opportunity> opportunitiesMap = L_QueryHandler.getOpportunitiesMapById(parentOppIDs);
        Map<Id, List<OpportunityLineItem>> oppLIPerOpportunityIdMap = L_QueryHandler.getOppLIPerOpportunityParentId(parentOppIDs);
        
        Decimal trucksCounter = 0;
        Decimal servicesCounter = 0;
        Decimal servicesValue = 0;
        
        for(Id oppId : oppLIPerOpportunityIdMap.keySet()){
            trucksCounter = 0;
        	servicesCounter = 0;
            for(OpportunityLineItem oppLIObj : oppLIPerOpportunityIdMap.get(oppId)){
                trucksCounter += oppLIObj.Quantity;
                if(oppLIObj.L_AddedService__c){
                   servicesCounter += oppLIObj.Quantity;
                   servicesValue += oppLIObj.TotalPrice;
                }
            }
            
            opportunitiesMap.get(oppId).L_TrucksQuantity__c = trucksCounter;
            opportunitiesMap.get(oppId).L_ServicesQuantity__c = servicesCounter;
            opportunitiesMap.get(oppId).L_ServicesAmount__c = servicesValue * L_Constants.TRUCK_SERVICE_PERCENTAGE;
        }
        
        update opportunitiesMap.values();        
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To get OpportunityIds Set from the given opportunities LI list.
    **************************************************************************************************/
    private static Set<Id> getOpportunityParentIds(List<OpportunityLineItem> oppLIlist) {
        
        Set<Id> oppSetIds = new Set<Id>();
        
        for(OpportunityLineItem oppLIObj : oppLIlist){
            oppSetIds.add(oppLIObj.OpportunityId);
        }
        
        return oppSetIds;
    }
    
}