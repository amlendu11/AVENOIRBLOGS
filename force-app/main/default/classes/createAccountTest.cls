/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
*  Description : class to test CreateAccount.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       07/02/2024   Initial Development
***********************************************************************/
@isTest
public class createAccountTest {

    /**
    * purpose : test callQueueable method of CreateAccount.cls
    * @param - NA
    * @return - NA
    **/
	@isTest
    public static void callQueueableTest() {
        Test.startTest();
        	CreateAccount.callQueueable(1);
        Test.stopTest();
        Integer size = AccountDomain.getAccountRecords().size();
        Assert.areEqual(1 , size);
    }
}