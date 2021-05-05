public with sharing class L_OpportunityLineITem_Handler extends L_TriggerHandler {
    private List<OpportunityLineItem> oldList;
    private List<OpportunityLineItem> newList;
    private Map<Id, OpportunityLineItem> oldMap;
    private Map<Id, OpportunityLineItem> newMap;

	public L_OpportunityLineITem_Handler() {
        this.oldList = (List<OpportunityLineItem>) Trigger.Old;
        this.newList = (List<OpportunityLineItem>) Trigger.New;
        this.oldMap  = (Map<Id, OpportunityLineItem>) Trigger.OldMap;
        this.newMap  = (Map<Id, OpportunityLineItem>) Trigger.NewMap;		
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
        L_OpportunityLineItem_TL.calculateOpportunityParentCounters(newList);
	}
	
	public override void afterUpdate() {					
        L_OpportunityLineItem_TL.calculateOpportunityParentCounters(newList);
	}

	/*
	public override void afterDelete() {
		//
	}

	public override void afterUndelete() {
		//
	}*/

}