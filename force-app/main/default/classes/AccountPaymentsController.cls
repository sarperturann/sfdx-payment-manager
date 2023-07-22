public with sharing class AccountPaymentsController {
    @AuraEnabled
    public static List<Account> getAccounts(){
        return [SELECT Id, Name 
                FROM Account
                ORDER BY Name ASC];
    }

    @AuraEnabled
    public static List<Payment__c> getPayments(Id accId){
        return [SELECT Id, Name, Amount__c, Due_Date__c, Payment_Type__c, Account__c, Notes__c
                FROM Payment__c 
                WHERE Account__c = :accId
                ORDER BY Due_Date__c ASC];
    }

    @AuraEnabled
    public static void insertPayment(Payment__c payment){
        try {
            insert payment;
            System.debug('Successful! payment -> ' + payment);
        } catch (Exception e) {
            System.debug('Couldn\'t insert payment, Error: ' + e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}