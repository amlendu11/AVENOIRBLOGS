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
}