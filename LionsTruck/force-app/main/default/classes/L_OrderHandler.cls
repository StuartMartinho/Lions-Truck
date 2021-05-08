public with sharing class L_OrderHandler extends L_TriggerHandler {
    private List<Order> oldList;
    private List<Order> newList;
    private Map<Id, Order> oldMap;
    private Map<Id, Order> newMap;

	public L_OrderHandler() {
        this.oldList = (List<Order>) Trigger.Old;
        this.newList = (List<Order>) Trigger.New;
        this.oldMap  = (Map<Id, Order>) Trigger.OldMap;
        this.newMap  = (Map<Id, Order>) Trigger.NewMap;		
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
        L_Order_TL.createOrderItems(newList);
	}
	
	public override void afterUpdate() {
        L_Order_TL.closeOpportunity(L_Order_TL.filterReceivedOrders(newList));
	}

	/*
	public override void afterDelete() {
		//
	}

	public override void afterUndelete() {
		//
	}*/

}