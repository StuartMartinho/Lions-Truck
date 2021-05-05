public with sharing class L_ServiceInteractionHandler extends L_TriggerHandler {
    private List<L_ServiceInteraction__c> oldList;
    private List<L_ServiceInteraction__c> newList;
    private Map<Id, L_ServiceInteraction__c> oldMap;
    private Map<Id, L_ServiceInteraction__c> newMap;

	public L_ServiceInteractionHandler() {
        this.oldList = (List<L_ServiceInteraction__c>) Trigger.Old;
        this.newList = (List<L_ServiceInteraction__c>) Trigger.New;
        this.oldMap  = (Map<Id, L_ServiceInteraction__c>) Trigger.OldMap;
        this.newMap  = (Map<Id, L_ServiceInteraction__c>) Trigger.NewMap;		
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
        system.debug('entrei');
        L_ServiceInteraction_TL.updateAssetDetails(newList);
	}
	
	/*public override void afterUpdate() {
	}*/

	/*
	public override void afterDelete() {
		//
	}

	public override void afterUndelete() {
		//
	}*/

}