@isTest(SeeAllData=False)
public without sharing class L_Opportunity_TLTest {
    
    @testSetup static void loadData(){
        Id pricebookId = Test.getStandardPricebookId();
        
        //Accounts
        Account testAcc = L_TestDataFactory.createAccount('TestAcc');
        insert testAcc;
        
        //Opportunities
        Opportunity oppTest = L_TestDataFactory.createOpp('Test Opp', 'Draft', testAcc.id);
        insert oppTest;
        
        //Products
        Product2 productTest = L_TestDataFactory.createProduct('TestProd');
        insert productTest;
        
        //Pricebook Entries
        PricebookEntry pbeTest = L_TestDataFactory.createPBE(50.000, productTest.Id, pricebookId);
        insert pbeTest;
        
        //Opportunity Line Items
        OpportunityLineItem oppLI = L_TestDataFactory.createOppLI(oppTest.Id, pbeTest.Id, testAcc.Id, 1, 50.000);
        insert oppLI;
        
        Order orderTest = L_TestDataFactory.createOrder(testAcc.Id, pricebookId, 'Draft', oppTest.Id);
        insert orderTest;
        
        OrderItem orderItemTest = L_TestDataFactory.createOrderItem(pbeTest.Id, orderTest.Id, 50.000, 1);
        insert orderItemTest;

    }
    
    /*************************************************************************************************
    * @Author:     Stuart Martinho
    * @Date:      07/05/2021
    * @Description: Below method is used to cover processClosedWonOpportunities method
    *************************************************************************************************/   
    static testMethod void testProcessClosedWonOpportunities(){
        Account accountTest = [SELECT Id, Name FROM Account WHERE name =:'TestAcc' LIMIT 1];
        Order orderTest = [SELECT Id FROM Order Where AccountId =:accountTest.Id LIMIT 1];
        
        Test.startTest();
        orderTest.Status = L_Constants.ORDERRECEIVED_STATUS;
        update orderTest;
        Test.stopTest();
        Opportunity oppTest = [SELECT Id, StageName FROM Opportunity WHERE Name='Test Opp' LIMIT 1];
        system.assertEquals(L_Constants.OPP_CLOSED_STATUS, oppTest.StageName);
    }

}