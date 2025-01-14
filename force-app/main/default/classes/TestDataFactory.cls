/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Sourav Dash
* Ticket Number: AVEBLOG122
--------------------------------------------------------------------------------
* Purpose/ Methods: This is test data factory of QueryChunkingQueuable.
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Sourav Dash       25/11/2024   Initial Development
* ****************************************************************************/
public with sharing class TestDataFactory {

    public static void createAccounts(Integer numberOfAccounts) {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < numberOfAccounts; i++) {
            accounts.add(new Account(Name = 'Test Account ' + i));
        }
        AccountDomain.insertAllAccounts(accounts);
    }
}