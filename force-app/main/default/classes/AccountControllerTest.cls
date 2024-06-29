/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Akash Kumar
* Ticket Number: AVEBLOG89
--------------------------------------------------------------------
* Description: test class for AccountController.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0      Akash Kumar         29/06/2024    Initial Development
***********************************************************************/
@isTest
public class AccountControllerTest {

    /**
    * purpose : testing getAccountList of AccountController.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void testgetAccountList() {
        Account account = AccountDomain.insertAccount('Test Account', '123456');
        Contact contact = new Contact(
            FirstName = 'First',
            LastName = 'Contact',
            AccountId = account.Id
        );
        insert contact;
        test.startTest();
        AccountController.getAccountList();
        test.stopTest();
        Assert.areEqual('Test Account', account.Name);
    }
    
    /**
    * purpose : testing getAccountRecord of AccountController.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void testgetAccountRecord() {
        Account account = AccountDomain.insertAccount('Test Account', '123456');
        test.startTest();
        AccountController.getAccountRecord(account.Id);
        test.stopTest();
        Assert.areEqual('Test Account', account.Name);
    }
}