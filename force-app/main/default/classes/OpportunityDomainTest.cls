/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
* Description: test class for OpportunitytDomain.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0      Anchal Agrawal      07/02/2024   Initial Development
***********************************************************************/
@isTest
public with sharing class OpportunityDomainTest {

    /**
    * purpose : method aims to test getOpportunityRecords method of OpportunitytDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void getOpportunityRecordsTest() {
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Opportunity opportunity = OpportunityDomain.createAndInsertOpportunity(account);
        Test.startTest();
            List<Opportunity> opportunities = OpportunityDomain.getOpportunityRecords();
        Test.stopTest();
        Assert.areNotEqual(null, opportunities[0].Id);
    }

    /**
    * purpose : method aims to test createAndInsertOpportunity method of OpportunitytDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void createAndInsertOpportunityTest() {
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Test.startTest();
            Opportunity opportunity = OpportunityDomain.createAndInsertOpportunity(account);
        Test.stopTest();
        Assert.areEqual(account.Id, opportunity.AccountId);
    }

    /**
    * purpose : method aims to test createAndInsertOpportunity method of OpportunitytDomain.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    public static void getOpportunityRecordsByAccountTest() {
        Account account = AccountDomain.insertAccount('Test', '1234567890');
        Opportunity opportunity = OpportunityDomain.createAndInsertOpportunity(account);
        Test.startTest();
            List<Opportunity> opportunities = OpportunityDomain.getOpportunityRecords(account);
        Test.stopTest();
        Assert.areEqual(account.Id, opportunities[0].AccountId);
    }
}