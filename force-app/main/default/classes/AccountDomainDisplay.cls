/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Nikhil Mehra
* Ticket Number:AVEBLOG31
------------------------------------------------------------------------
* Blog: Fetching and Displaying Account and Contact Data in a Lightning Web Component
------------------------------------------------------------------------
* Purpose/ Methods: Account Domain class to perform all DML operation.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Nikhil Mehra        8/17/2023     Initial Development
***********************************************************************/
public with sharing class AccountDomainDisplay {
    @AuraEnabled(Cacheable= True)
    public static List<Account> getAccounts() {
        return [
            SELECT 
            	Id,
            	Name,
            	AccountNumber,
            	Phone,
            	Industry,
                (
                    SELECT 
                        Id,
                        FirstName,
                        LastName
                    FROM
                        Contacts
                )
            FROM
            	Account
            LIMIT
            	200
        ];
    }
}
