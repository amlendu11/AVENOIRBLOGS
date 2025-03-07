/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by:Satish Yadav
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Simplifying Error Handling with Improved Apex Exception Emails
--------------------------------------------------------------------
* Purpose/ Methods: This is test class for ErrorHandlingDemo
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME       DATE        DETAIL FEATURES
   1.0       Satish Yadav       23/02/2025   Initial Development
***********************************************************************/

@isTest
private class ErrorHandlingDemoTest {
    
    @isTest
    static void testSimulateAccountInsertLimitError() {
        List<Account> testAccounts = new List<Account>();
        for (Integer i = 0; i < 5; i++) {
            testAccounts.add(new Account(Name = 'Test Account ' + i));
        }

        Test.startTest();
        try {
            ErrorHandlingDemo.simulateAccountInsertLimitError(testAccounts);
            System.assert(false, 'Expected an exception to be thrown');
        } catch (Exception e) {
            System.assert(e != null, 'Exception should be thrown');
            System.debug('Caught Exception: ' + e.getMessage());
        }
        Test.stopTest();
    }
}