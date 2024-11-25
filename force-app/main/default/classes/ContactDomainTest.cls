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
*   1.0      Anchal Agrawal      07/02/2024   Initial Development
***********************************************************************/
@isTest
public with sharing class ContactDomainTest  {

    /**
    * purpose : method aims to test ContactDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void createAndInsertContactTest() {
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Test.startTest();
        Contact contact = ContactDomain.createAndInsertContact(account);
        Test.stopTest();
        Assert.areEqual(account.Id, contact.AccountId);
    }
}