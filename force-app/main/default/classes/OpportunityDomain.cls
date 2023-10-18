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
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        13/10/2023    Initial Development   
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
}