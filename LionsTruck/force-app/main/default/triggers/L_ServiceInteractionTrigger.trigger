trigger L_ServiceInteractionTrigger on L_ServiceInteraction__c (before update, after update, after insert, before insert) {
	new L_ServiceInteractionHandler().run();
}