/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
* Description : test class for DataDeletionController.
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       16/06/2024   Initial Development
***********************************************************************/
@isTest
public with sharing class DataDeletionControllerTest {

    /**
    * purpose : test recordsToDelete method of DataDeletionController.
    * @param - NA
    * @return - NA
    **/
    @isTest
    public static void testRecordsToDelete() {
        Account acc = new Account(Name='Test');
        insert acc;
        Test.startTest();
            DataDeletionController.recordsToDelete(22);
        Test.stopTest();
        Integer size = AccountDomain.getAccountRecords().size();
        Assert.areEqual(0, size);
    }
}