public with sharing class L_TestDataFactory {
	 
    public static Opportunity createOpp(String name, String stageName, id accId){
        Opportunity opp = new Opportunity();
        opp.AccountId = accId;
        opp.Name = name;
        opp.CloseDate = System.today().addMonths(1);
        opp.StageName = stageName;
        return opp;
    }
    
    public static Account createAccount(String name){
        Account account = new Account(Name = name);
        return account;
    }
    
    public static Product2 createProduct(String name){
        Product2 product = new Product2(Name = name, ProductCode = name, isActive = true);
        return product;
    }
    
    public static PricebookEntry createPBE(Decimal unitPrice, id productId, Id pricebookId){
        PricebookEntry pbEntry = new PricebookEntry(Pricebook2Id = pricebookId, Product2Id = productId, UnitPrice = unitPrice, IsActive = true);
        return pbEntry;
    }
    
    public static OpportunityLineItem createOppLI(Id oppID, Id pricebookEntryId, id accId, Decimal quantity, Decimal unitPrice){
        OpportunityLineItem oppLI = new OpportunityLineItem(OpportunityId = oppID, PricebookEntryId = pricebookEntryId, 
                                                            Quantity= quantity, TotalPrice = quantity * unitPrice);
        return oppLI;
    }
    
    public static Order createOrder(Id accId, Id pricebookId, String status, Id oppId){
        Order order = new Order(Pricebook2Id = pricebookId, Status= status, EffectiveDate = System.today(), 
                                AccountId = accId, OpportunityId= oppId);
        return order;        
    }

    public static OrderItem createOrderItem(Id pbeId, Id orderId, Decimal unitPrice, Decimal quantity){ 
        OrderItem orderItem = new OrderItem(UnitPrice = unitPrice, OrderId = orderId, PricebookEntryId = pbeId, Quantity = quantity);
        return orderItem;
    }
}