/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG112
--------------------------------------------------------------------
* Purpose/ Methods: This is test class of AccountController.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.1       Diksha Dewangan      08/07/2024    Added getAccounts
***********************************************************************/
@isTest
public with sharing class AccountControllerTest {

    @testSetup
    static void setup() {
        // Create sample Account records for testing
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            accounts.add(new Account(
                Name = 'Test Account ' + i,
                Industry = 'Technology',
                Type = 'Customer',
                Rating = 'Hot',
                Ownership = 'Public'
            ));
        }
        insert accounts;
    }

    @isTest
    static void testGetAccounts() {
        Test.startTest();
        List<AccountWrapper> result = AccountController.getAccounts();
        Test.stopTest();
        System.assertNotEquals(
            0,
            result.size(),
            'Expected non-zero number of AccountWrapper records.'
        );
    }
}