@isTest
private class AccountPaymentsControllerTest{
    @isTest
    static void testGetAccounts(){
        List<Account> tempAccs = new List<Account>();
        for(Integer i = 0; i <= 4; i++){
            tempAccs.add(new Account(Name = 'Test Account ' + i));
        }
        insert tempAccs;

        Test.startTest();

        List<Account> accounts = AccountPaymentsController.getAccounts();

        Test.stopTest();

        System.assertEquals(tempAccs.size(), accounts.size());
        for(Integer i = 0; i <= 4; i++){
            System.assertEquals(tempAccs[i].Id, accounts[i].Id);
            System.assertEquals(tempAccs[i].Name, accounts[i].Name);
        }
    }
    
    @isTest
    static void testGetPayments(){
        Account testAccount = new Account(Name='Test Account');
        Account testAccount2 = new Account(Name='Test Account 2');
        insert testAccount;
        insert testAccount2;
        
        List<Payment__c> payments = new List<Payment__c>();
        payments.add(
            new Payment__c(
                Account__c = testAccount.Id, 
                Payment_Type__c = 'Service', 
                Amount__c = 100,
            	Due_Date__c = System.Today().addDays(1)));
        payments.add(
            new Payment__c(
                Account__c = testAccount.Id, 
                Payment_Type__c = 'Product', 
                Amount__c = 150,
            	Due_Date__c = System.Today().addDays(2)));
        payments.add(
            new Payment__c(
                Account__c = testAccount2.Id, 
                Payment_Type__c = 'Service', 
                Amount__c = 100,
            	Due_Date__c = System.Today().addDays(1)));
        insert payments;

        Test.startTest();

        List<Payment__c> returnedPayments = AccountPaymentsController.getPayments(testAccount.Id);

        Test.stopTest();

        System.assertEquals(2, returnedPayments.size());
        for(Integer i = 0; i < returnedPayments.size(); i++){
            System.assertEquals(payments[i].Payment_Type__c, returnedPayments[i].Payment_Type__c);
            System.assertEquals(payments[i].Amount__c, returnedPayments[i].Amount__c);
        }
    }
    
    @isTest
    static void testInsertPayment() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        
        Payment__c newPayment =  new Payment__c(
                                    Account__c = testAccount.Id, 
                                    Payment_Type__c = 'Service', 
                                    Amount__c = 100,
                                    Due_Date__c = System.Today().addDays(1));
        
        Test.startTest();
        AccountPaymentsController.insertPayment(newPayment);
        Test.stopTest();
        
        List<Payment__c> returnedPayments = AccountPaymentsController.getPayments(testAccount.Id); 
        System.assertEquals(1, returnedPayments.size());
        System.assertEquals('Service', returnedPayments[0].Payment_Type__c);
        System.assertEquals(100, returnedPayments[0].Amount__c);
        System.assertEquals(System.Today().addDays(1), returnedPayments[0].Due_Date__c);
    }
}