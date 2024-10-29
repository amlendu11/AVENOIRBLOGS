/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Nikhil Mehra
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Fetching and Displaying Account and Contact Data in a Lightning Web Component
--------------------------------------------------------------------
* Purpose/ Methods: This is Processor class.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Nikhil Mehra         08/17/2023    Initial Development
   3.0       Shiv Kumar Chaudhary 11/03/2024    Added processMultipleAccountToInsert
   1.3       Diksha Dewangan      22/06/2024    Added getWrappedAccounts
   4.0       Akash Kumar          29/06/2024    Added getProcessedRecord
***********************************************************************/
public with sharing class AccountProcessor {
    public static List<AccountWrapper> getdomain() {
        List<AccountWrapper> processedData = new List<AccountWrapper>();
        for(Account acc : AccountDomainDisplay.getAccounts()) {
            processedData.add(new AccountWrapper(acc));
        }
        return processedData;
    }

    /**
    * This method aims to insert multiple Account
    * @param Account name
    * @param Account phone
    * @param Account number
    * @return N/A
    */
    public static void processMultipleAccountToInsert(
        List<InsertMultipleAccountWrapper> accounts
    ) {
        List<Account> accountsToInsert = new List<Account>();
        for (InsertMultipleAccountWrapper account : accounts) {
            accountsToInsert.add(new Account(
                Name = account.accountName,
                Phone = account.accountPhone,
                AccountNumber = account.accountNumber
            ));
        }
        AccountDomain.insertAccounts(accountsToInsert);
    }

    /* This Method aims to get accounts
        @Param :  N/A
        @return : List<AccountWrapper>
    */
    @AuraEnabled
    public static List<AccountWrapper> getWrappedAccounts() {
        List<AccountWrapper> wrappedAccounts = new List<AccountWrapper>();
		for (Account accountObj : AccountDomain.getAccountRecords()) {
            wrappedAccounts.add(new AccountWrapper(accountObj));
        }
        return wrappedAccounts;
    }

    /**
    * This method aims to get Account Record
    * @param : String recordId
    * @return : Account record
    */
    public static AccountWrapper getProcessedRecord(String recordId) {
        AccountWrapper processedAccountrecord;
        Account acc = AccountDomain.getAccountData(recordId);
        processedAccountrecord = new AccountWrapper(acc);
        return processedAccountrecord;
    }
}