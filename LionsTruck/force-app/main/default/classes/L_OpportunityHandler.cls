public with sharing class L_OpportunityHandler extends L_TriggerHandler {
    private List<Opportunity> oldList;
    private List<Opportunity> newList;
    private Map<Id, Opportunity> oldMap;
    private Map<Id, Opportunity> newMap;

	public L_OpportunityHandler() {
        this.oldList = (List<Opportunity>) Trigger.Old;
        this.newList = (List<Opportunity>) Trigger.New;
        this.oldMap  = (Map<Id, Opportunity>) Trigger.OldMap;
        this.newMap  = (Map<Id, Opportunity>) Trigger.NewMap;		
	}
	/*
	public override void beforeInsert() {
		//
	}
	*/
	/*public override void beforeUpdate() {
	}
	/*	
	public override void beforeDelete() {
		//
	}	
	*/
	public override void afterInsert() {
	}
	
	public override void afterUpdate() {
        L_Opportunity_TL.processClosedWonOpportunities(L_Opportunity_TL.filterClosedWonOpps(oldMap,newMap));
	}

	/*
	public override void afterDelete() {
		//
	}

	public override void afterUndelete() {
		//
	}*/

}