trigger L_OpportunityTrigger on Opportunity (before update, after update, after insert, before insert) {
	new L_OpportunityHandler().run();
}