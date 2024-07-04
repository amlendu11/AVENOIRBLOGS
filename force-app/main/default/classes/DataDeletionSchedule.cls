/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
*  Description : Schedule apex class to execute the job in time interval.
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       16/06/2024   Initial Development
***********************************************************************/
public with sharing class DataDeletionSchedule implements Schedulable {
    List<Account> accounts;
    public DataDeletionSchedule(List<Account> accounts) {
        this.accounts = accounts;
    }

    /**
    * purpose : execute method of schedulable interface to delete records
    * on time interval.
    * @param - SchedulableContext sc
    * @return - NA
    **/
    public void execute(SchedulableContext sc) {
        ScheduleDelete__c lastSchedule;
        try {
            lastSchedule = ScheduleDelete__c.getInstance(System.Label.SCHEDULE_JOB_NAME);
        } catch(Exception nullException) {
            throw nullException;
        }
        if(lastSchedule.LastRunDate__c == null) {
            AccountDomain.deleteAccounts(accounts);
            lastSchedule.LastRunDate__c = Date.today();
            ScheduleDeleteDomain.updateScheduleDelete(
                new List<ScheduleDelete__c>{lastSchedule}
            );
        }
        else {
            if(Date.today().monthsBetween(lastSchedule.LastRunDate__c) == lastSchedule.MonthInterval__c) {
                AccountDomain.deleteAccounts(accounts);
                lastSchedule.LastRunDate__c = Date.today();
                ScheduleDeleteDomain.updateScheduleDelete(
                    new List<ScheduleDelete__c>{lastSchedule}
                );
            }
        }
    }
}