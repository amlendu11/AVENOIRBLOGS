/************************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG61
------------------------------------------------------------------------
* Blog: CUSTOM LOOKUP FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is domain class to query object data.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME     DATE         DETAIL FEATURES  
   1.0        Pooja Ahuja    13/10/2023    Initial Development  
   2.0       Anchal Agrawal  16/02/2024  Added getOpportunityRecords
   2.1       Anchal Agrawal  16/02/2024  Added createAndInsertOpportunity
***********************************************************************/
global without sharing class OpportunityDomain {
    public static List<Opportunity> getOpportunityRecords() {
        return [
            SELECT
                Id,
                Name,
                Amount,
                Account.Name,
                CloseDate,
                Owner.Name,
                OwnerId,
                CreatedDate,
                LastModifiedDate
            FROM
                Opportunity
        ];
    }

    /**
    * This method aims to insert Opportunity
    * @param account
    * @return Opportunity
    */
    public static Opportunity createAndInsertOpportunity(Account account) {
        Opportunity opportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Qualification',
            CloseDate = System.today(),
            AccountId = account.Id
        );
        insert opportunity;
        return opportunity;
    }

    /**
    * This method aims to get Opportunity record
    * @param NA
    * @return List<Opportunity>
    */
    public static List<Opportunity> getOpportunityRecords(Account account) {
        return [
        	SELECT
            	Id,
                AccountId
            FROM
            	Opportunity
            WHERE
            	AccountId = :account.Id
       	];
    }
}