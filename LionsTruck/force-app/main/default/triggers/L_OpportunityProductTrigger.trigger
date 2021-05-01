trigger L_OpportunityProductTrigger on OpportunityLineItem (before update, after update, after insert, before insert) {
	new L_OpportunityLineITem_Handler().run();
}