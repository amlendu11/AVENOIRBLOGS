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
   3.1       Diksha Dewangan      22/06/2024  Updated getAccountRecords
                                              query(AVEBLOG-112)
   4.0       Anchal Agrawal       16/06/2024  Added deleteAccounts
   5.0       Akash Kumar          29/06/2024  Added getAccountData
   6.0       Sourav Dash          14/01/2025  Added getAllAccountRecords
                                              & insertAllAccounts
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
                Phone,
				Industry,
            	Type,
            	Rating,
            	Ownership
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

    /**
    * This method aims to delete Account record
    * @param List<Account>
    * @return N/A
    */
    public static void deleteAccounts(List<Account> accounts) {
        try {
            delete accounts;
        }
        catch (Exception DMLException) {
            throw DMLException;
        }
    }

    /**
    * This method aims to get Account record
    * @param String
    * @return Account
    */
    public static Account getAccountData(String recordId) {
        return [
            SELECT
                Id,
                Name,
                Restricted__c
            FROM
                Account
            WHERE
                Id =:recordId 
        ]
      }
        
     /**
    * This method aims for simulate unhandled exception
    * @param List<Accont>
    * @return NA
    */
    public static void causeInsertLimitError (List<Account> accounts) {
        Account accounts = new Account();
        insert accounts;
    }
}


    /**
     * Retrieve Account records
     * @return List<Account>
     */
    public static List<Account> getAllAccountRecords() {
        return [
            SELECT
                Id,
                Name
            FROM
                Account
        ];
    }

    /**
     * Insert multiple Account records
     * @param accounts - List of Account objects to insert
     */
    public static void insertAllAccounts(List<Account> accounts) {
        try {
            insert accounts;
        }
        catch (Exception e) {
            throw e;
        }
    }
}

