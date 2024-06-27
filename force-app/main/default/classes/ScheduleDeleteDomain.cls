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
    * purpose : to query scheduleDelete__c records.
    * @param - String name
    * @return - ScheduleDelete__c
    **/
   public static ScheduleDelete__c getScheduleDeleteRecords(String name) {
        return [
            SELECT
                Id,
                Name,
                LastRunDate__c,
                MonthInterval__c
            FROM
                ScheduleDelete__c
            WHERE
                Name = :name
            LIMIT 1
        ];
   }
}