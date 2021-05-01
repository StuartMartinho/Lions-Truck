trigger L_OrderTrigger on Order (before update, after update, after insert, before insert) {
	new L_OrderHandler().run();
}