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
   1.0       Shiv Kumar Chaudhary 19/4/2023   Initial Development
   2.0       Anchal Agrawal       16/02/2024  Added getAccountRecords
   3.0       Shiv Kumar Chaudhary 11/03/2024  Added insertAccounts
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

    /**
    * This method aims to get Account record
    * @param NA
    * @return List<Account>
    */
    public static List<Account> getAccountRecords() {
        return [
        	SELECT
            	Id,
                Name,
                Phone
            FROM
            	Account
       	];
    }

    /**
    * This method aims to insert Account record
    * @param List<Account>
    * @return N/A
    */
    public static void insertAccounts(List<Account> accounts) {
        try {
            insert accounts;
        } 
        catch (Exception e) {
            throw e;
        }
    }
}