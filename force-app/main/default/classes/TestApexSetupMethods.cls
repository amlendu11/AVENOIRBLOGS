/********************************************************************
* (c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Sourav Dash
* Ticket Number: AVEBLOG 104
--------------------------------------------------------------------
* Description: test class for TestApexSetupMethods.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0     Sourav Dash         01/08/2024    Initial Development
***********************************************************************/
@isTest
public class TestApexSetupMethods {

    @testSetup
    static void setupTestData() {
        Account acc = new Account(Name = 'Test Account');
        insert acc;
    }

    @isTest
    static void testMethod1() {
        Account acc = [
            SELECT
                Id,
                Name
            FROM
                Account
            LIMIT 1
        ];
        System.assertEquals('Test Account', acc.Name);
    }

    @isTest
    static void testMethod2() {
        Account acc = [
            SELECT
                Id,
                Name
            FROM
                Account
            LIMIT 1
        ];
        System.assert(acc != null, 'Account should not be null');
    }
}