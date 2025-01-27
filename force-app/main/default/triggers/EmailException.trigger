/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by:Satish Yadav
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Simplifying Error Handling with Improved Apex Exception Emails.
--------------------------------------------------------------------
* Purpose/ Methods: This is trigger for simulate unhandled exception.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME       DATE        DETAIL FEATURES
   1.0       Satish Yadav       23/01/2025   Initial Development
***********************************************************************/

trigger EmailException on Account (before insert) {
    ErrorHandlingDemo.simulateLimitError(Trigger.new);
}