/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG111
--------------------------------------------------------------------------------
* Purpose/Methods: Return the required result.
* Class: BatchToSyncExternalAccountRecord.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Shiv K Chaudhary    09/11/2024   Initial Development
* ****************************************************************************/
public with sharing class BatchToSyncExternalAccountRecord implements Database.Batchable<sObject> {
     /**
    * This method aims return the required result.
    * @param context
    * @return Database.QueryLocator
    */
    public Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator('SELECT Id, Name__c, Industry__c FROM Account__x');
    }

     /**
    * This method aims to process the Sync the Account Data
    * @param context
    * @param externalAccounts
    */
    public void execute(Database.BatchableContext context, List<Account__x> externalAccounts) {
        List<Account> accountsToUpsert = new List<Account>();
        for (Account__x externalAccount : externalAccounts) {
            // Map fields to target org’s Account object
            Account accountNew = new Account();
            accountNew.External_Id__c = externalAccount.Id;
            accountNew.Name = externalAccount.Name__c;
            accountsToUpsert.add(accountNew);
        }
        upsert accountsToUpsert Account.External_Id__c;
    }

    /**
    * This method aims to process show the results
    * @param context
    */
    public void finish(Database.BatchableContext context) {
        System.debug(System.label.ACCOUNT_SYNC_COMPLETED);
    }
}