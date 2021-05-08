public without sharing class L_Order_TL {

    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: This method is used to Create Order Items whenever a Order is created.
    **************************************************************************************************/
    public static void createOrderItems(List<Order> ordersList){
        Set<Id> oppIDs = getOpportunityIdsFromOrders(ordersList);  
        List<OrderItem> orderItemsInsert = new List<OrderItem>();
        Map<Id,Id> orderPBIdMap = getPricebookPerOrderMap(ordersList); 
        List<PricebookEntry> pbEntryList = L_QueryHandler.getPricebookEntriesFromPricebookId(orderPBIdMap.values());
        Map<Id, List<OpportunityLineItem>> oppLIPerOpportunityIdMap = L_QueryHandler.getOppLIPerOpportunityParentId(oppIDs);
        
        for(Order orderObj : ordersList){
            
            for(OpportunityLineItem oppLIObj : oppLIPerOpportunityIdMap.get(orderObj.OpportunityId)){
                if(orderObj.L_OpportunityLineItemId__c == oppLIObj.id){
                	Id testId = getPricebookEntryId(pbEntryList, oppLIObj.Product2Id, OrderPBIdMap.get(orderObj.id));                
            		OrderItem orderItemAux = new OrderItem(OrderId=orderObj.id,Product2Id=oppLIObj.Product2Id,Quantity=oppLIObj.Quantity, UnitPrice=oppLIObj.UnitPrice,
                                                       PricebookEntryId=testId, L_ServiceAmount__c= (oppLIObj.TotalPrice * L_Constants.TRUCK_SERVICE_PERCENTAGE));
                	orderItemsInsert.add(orderItemAux);    
                }
        	}
        }
        
        insert orderItemsInsert;        
    }

    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To update a Opportunity to Closed Won status, whenever all the child orders, are set to
    Received status.
    **************************************************************************************************/
    public static void closeOpportunity(List<Order> ordersList){
        
        if(ordersList.isEmpty())
            return;
        
        Set<Id> oppIdsSet = getOpportunityIdsFromOrders(ordersList);
        Map<Id, Opportunity> parentOppMAp = L_QueryHandler.getOpportunitiesMapById(oppIdsSet);
        Map<Id, List<Order>> orderByOppIdMap = L_QueryHandler.getOrdersByOpportunityIdMap(oppIdsSet);
        List<Opportunity> oppsToClose = new List<Opportunity>();
        List<Opportunity> oppsToCloseAux = new List<Opportunity>();
        
        boolean isOrderPaid = true;
        for(Id oppId : orderByOppIdMap.keySet()){
            isOrderPaid = true;
            for(Order orderObj : orderByOppIdMap.get(oppId)){
                if(!orderObj.Status.equalsIgnoreCase(L_Constants.ORDERRECEIVED_STATUS)){
                    isOrderPaid=false;
                    break;
                }
            }
            if(isOrderPaid)
            {
                oppsToClose.add(parentOppMAp.get(oppId));
            }
            
        }
        
        if(!oppsToClose.isEmpty())
        {
            setOppsToClose(oppsToClose);
        	update oppsToClose;
        }
        
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To get OpportunityIds Set from the given Order list.
    **************************************************************************************************/
    private static Set<Id> getOpportunityIdsFromOrders(List<Order> ordersList) {
        
        Set<Id> oppSetIds = new Set<Id>();
        
        for(Order orderObj : ordersList){
            oppSetIds.add(orderObj.OpportunityId);
        }
        
        return oppSetIds;
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To get Pricebooks per order from the given Order list.
    **************************************************************************************************/
    private static Map<Id,Id> getPricebookPerOrderMap(List<Order> ordersList) {
        
        Map<Id,Id> mapToReturn = new Map<Id,Id>();
        
        for(Order orderObj : ordersList){
            mapToReturn.put(orderObj.id, orderObj.Pricebook2Id);
        }
        
        return mapToReturn;
    }
    
    private static Id getPricebookEntryId(List<PricebookEntry> pBEntryList, Id productId, Id pricebookId) {
        
        for(PricebookEntry pbEntryObj : pBEntryList){
            if(pbEntryObj.Product2Id == productId && pbEntryObj.Pricebook2Id == pricebookId){
                return pbEntryObj.id;
            }
        }
        
        return null;
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: Set Opportunities to Closed Won status.
    **************************************************************************************************/
    private static void setOppsToClose(List<Opportunity> oppList)
    {
        for(Opportunity oppObj : oppList){
            oppObj.StageName = L_Constants.OPP_CLOSED_STATUS;
        }
    }
    
    /*************************************************************************************************
    * @Author:      Stuart Martinho
    * @Date:       07/05/2021
    * @Description: To Filter Orders that were changed to Received status
    **************************************************************************************************/
    public static List<Order> filterReceivedOrders(List<Order> orderList)
    {
        List<Order> listToReturn = new List<Order>();
        for(Order orderObj : orderList){
            if(orderObj.Status.equalsIgnoreCase(L_Constants.ORDERRECEIVED_STATUS)){
                listToReturn.add(orderObj);
            }
        }
        
        return listToReturn; 
    }
    
}