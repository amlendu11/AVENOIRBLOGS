/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Shiv Kumar Chaudhary
* Ticket Number:AVEBLOG11
------------------------------------------------------------------------
* Blog: ACTION FUNCTION IN VISUALFORCE PAGE SALESFORCE.
------------------------------------------------------------------------
* Purpose/ Methods: Account Domain class to perform all DML operation.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Shiv Kumar Chaudhary 4/19/2023   Initial Development
***********************************************************************/
public class AccountDomain {
    
    /**
    * This method aims to insert Account
    * @param name
    * @param phone
    * @return Account
    */
    public static Account insertAccount(String name, String phone){
        Account accounts = new Account(name = name, phone = phone);
        insert accounts;
        return accounts;
    }
}