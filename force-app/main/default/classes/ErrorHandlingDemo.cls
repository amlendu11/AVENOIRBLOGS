/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by:Satish Yadav
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Simplifying Error Handling with Improved Apex Exception Emails
--------------------------------------------------------------------
* Purpose/ Methods: This is trigger for simulate unhandled exception.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME       DATE        DETAIL FEATURES
   1.0       Satish Yadav       23/01/2025   Initial Development
***********************************************************************/
public class ErrorHandlingDemo {

/**
   * This method aims for simulate unhandled exception
   * @param List<Account>
   * @return NA
   */
    public static void simulateLimitError(List<Account> newAccounts) {
        Account accounts = new Account();
        insert accounts;
    }
}