/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
*  Description : class to test CreateOpportunity.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       07/02/2024   Initial Development
***********************************************************************/
@isTest
public class CreateOpportunityTest {

	/**
    * purpose : test execute method of CreateOpportunity.cls
    * @param - NA
    * @return - NA
    **/
    @isTest
    public static void createOpportunityTest() {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = 2;
        Account account = AccountDomain.insertAccount(
            'Test',
            '9987463210'
        );
        Test.startTest();
        	System.enqueueJob(new CreateOpportunity(account), asyncOptions);
        Test.stopTest();
        Integer size = OpportunityDomain.getOpportunityRecords(account).size();
        Assert.areEqual(1 , size);
    }
}