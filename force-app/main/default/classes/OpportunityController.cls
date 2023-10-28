/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG61
------------------------------------------------------------------------
* Blog: CUSTOM LOOKUP FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is controller class to get object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        13/10/2023    Initial Development   
***********************************************************************/
public with sharing class OpportunityController {
    @AuraEnabled(cacheable = true)
    public static List<OpportunityWrapper> getAllOpportunity() {
        return OpportunityProcessor.getOpportunityWrappedRecords();
    }

     @AuraEnabled(cacheable = true)
    public static List<Opportunity> getOpportunitiesBySearchTerm(String searchTerm) {
        String searchQuery = '%' + searchTerm + '%';
        return [
            SELECT 
                Id,
                Name, 
                Account.Name, 
                Amount, 
                CloseDate 
            FROM 
                Opportunity
            WHERE
                Name LIKE :searchQuery
            LIMIT 10
        ];
    }
}