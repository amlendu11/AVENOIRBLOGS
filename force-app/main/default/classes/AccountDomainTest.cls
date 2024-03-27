/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
* Description: test class for AccountDomain.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0      Anchal Agrawal      07/02/2024    Initial Development
***********************************************************************/
@isTest
public with sharing class AccountDomainTest {

    /**
    * purpose : testing insertAccount of AccountDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void insertAccountTest() {
        Test.startTest();
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Test.stopTest();
        Assert.areEqual('Test', account.Name);
    }

    /**
    * purpose : testing getAccountRecords of AccountDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void getAccountRecordsTest() {
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Test.startTest();
        List<Account> accounts = AccountDomain.getAccountRecords();
        Test.stopTest();
        Assert.areEqual('Test', accounts[0].Name);
    }
}