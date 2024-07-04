/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
*  Description : Domain class to query scheduleDelete__c records.
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       16/06/2024   Initial Development
***********************************************************************/
public with sharing class ScheduleDeleteDomain {

    /**
    * purpose : to insert scheduleDelete__c records.
    * @param - List<ScheduleDelete__c> lastSchedules
    * @return - NA
    **/
    public static void insertScheduleDelete(List<ScheduleDelete__c> lastSchedules) {
        try {
            insert lastSchedules;
        }
        catch (Exception nullException) {
            throw nullException;
        }
    }

    /**
    * purpose : to update scheduleDelete__c records.
    * @param - List<ScheduleDelete__c> lastSchedules
    * @return - NA
    **/
    public static void updateScheduleDelete(List<ScheduleDelete__c> lastSchedules) {
        try {
            update lastSchedules;
        }
        catch (Exception nullException) {
            throw nullException;
        }
    }
}