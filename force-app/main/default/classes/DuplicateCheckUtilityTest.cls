/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG1136
--------------------------------------------------------------------
*  Description : Duplicate record check.
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan       12/12/2024   Initial Development
***********************************************************************/
@isTest
public class DuplicateCheckUtilityTest {

    @isTest
    static void checkDuplicatesForSObjectEntryWithNoDuplicates() {
        List<SObject> testRecords = new List<SObject>();
        Account account = new Account(Name = 'Test Account');
        testRecords.add(account);
        Test.startTest();
        List<Boolean> results = DuplicateCheckUtility.checkDuplicatesForSObjectEntry(testRecords);
        Test.stopTest();
        System.assertEquals(1, results.size());
        System.assertEquals(false, results[0]);
    }

    @isTest
    static void checkDuplicatesForSObjectEntrWithDuplicates() {
        Account account1 = new Account(
            Name = 'Duplicate Account',
            BillingStreet = '123 Dup St',
            BillingCity = 'DuplicateCity'
       	);
        Account account2 = new Account(
            Name = 'Duplicate Account',
            BillingStreet = '123 Dup St',
            BillingCity = 'DuplicateCity'
        );
        insert account1;
        Test.startTest();
        List<Boolean> results = DuplicateCheckUtility.checkDuplicatesForSObjectEntry(
            new List<SObject> { account2 }
        );
        Test.stopTest();
        System.assertEquals(1, results.size());
        System.assertEquals(true, results[0]);
    }
}