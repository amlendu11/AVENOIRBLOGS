/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number:AVEBLOG82
------------------------------------------------------------------------
*  Description : Contact Domain class to perform all DML operation.
--------------------------------------------------------------------
* Utility Test Class: ContactDomainTest.cls
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal      07/02/2024   Initial Development
***********************************************************************/
public with sharing class ContactDomain {

    /**
    * This method aims to insert Contact
    * @param account
    * @return Contact
    */
    public static Contact createAndInsertContact(Account account) {
        Contact contact = new Contact(
            Lastname = 'Sharma',
            AccountId = account.Id
        );
        insert contact;
        return contact;
    }

    /**
    * This method aims to get Contact record
    * @param NA
    * @return List<Contact>
    */
    public static List<Contact> getContactRecords(Account account) {
        return [
        	SELECT
            	Id
            FROM
            	Contact
            WHERE
            	AccountId = :account.Id
       	];
    }
}