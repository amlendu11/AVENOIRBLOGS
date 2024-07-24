/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
* Description : class to test ScheduleDeleteDomain Class.
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       16/06/2024   Initial Development
***********************************************************************/
@isTest
public with sharing class ScheduleDeleteDomainTest {

    /**
    * purpose : this method aims to test insertScheduleDelete method.
    * @param - NA
    * @return - NA
    **/
    @isTest
    public static void testInsertScheduleDelete(){
        ScheduleDelete__c lastSchedule = new ScheduleDelete__c(
            Name = 'Test',
            LastRunDate__c = null,
            MonthInterval__c = 23
        );
        Test.startTest();
        ScheduleDeleteDomain.insertScheduleDelete(
            new List<ScheduleDelete__c>{lastSchedule}
        );
        Test.stopTest();
    }

     /**
    * purpose : this method aims to test updateScheduleDelete method.
    * @param - NA
    * @return - NA
    **/
    @isTest
    public static void testUpdateScheduleDelete(){
        ScheduleDelete__c lastSchedule = new ScheduleDelete__c(
            Name = 'Test',
            LastRunDate__c = null,
            MonthInterval__c = 23
        );
        ScheduleDeleteDomain.insertScheduleDelete(
            new List<ScheduleDelete__c>{lastSchedule}
        );
        lastSchedule.MonthInterval__c = 24;
        Test.startTest();
        ScheduleDeleteDomain.updateScheduleDelete(
            new List<ScheduleDelete__c>{lastSchedule}
        );
        Test.stopTest();
        ScheduleDelete__c scheduleDeletes = ScheduleDelete__c.getInstance('Test');
        Assert.areEqual(24, scheduleDeletes.MonthInterval__c);
    }
}