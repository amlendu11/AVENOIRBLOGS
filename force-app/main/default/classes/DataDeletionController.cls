/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
* Description : class to schedule a job for more than 12 months.
--------------------------------------------------------------------
* Utility Test Class: DataDeletionControllerTest
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       16/06/2024   Initial Development
***********************************************************************/
public with sharing class DataDeletionController {

    /**
    * purpose : Schedule a job to delete records.
    * @param - Integer scheduleInterval
    * @return - NA
    **/
    public static void recordsToDelete(Integer scheduleInterval) {
        List<Account> accounts = AccountDomain.getAccountRecords();
        String expCron = '0 0 0 1 * ? *';
        Id batchId = System.schedule(
            System.Label.SCHEDULE_JOB_NAME,
            expCron,
            new DataDeletionSchedule(accounts)
        );
        if(batchId != null) {
            ScheduleDelete__c lastSchedule;
            try{
                lastSchedule = ScheduleDelete__c.getInstance(System.Label.SCHEDULE_JOB_NAME);
            }
            catch(Exception SOQLException) {
                throw SOQLException;
            }
            if(lastSchedule != null) {
                lastSchedule.LastRunDate__c = null;
                lastSchedule.MonthInterval__c = scheduleInterval;
                ScheduleDeleteDomain.updateScheduleDelete(
                    new List<ScheduleDelete__c>{lastSchedule}
                );
            }
            else {
                lastSchedule = new ScheduleDelete__c(
                    Name = System.Label.SCHEDULE_JOB_NAME,
                    LastRunDate__c = null,
                    MonthInterval__c = scheduleInterval
                );
                ScheduleDeleteDomain.insertScheduleDelete(
                    new List<ScheduleDelete__c>{lastSchedule}
                );
            }
        }
    }
}