/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG61
------------------------------------------------------------------------
* Blog: CUSTOM LOOKUP FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is processor class to process object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        13/10/2023    Initial Development   
***********************************************************************/
public with sharing class OpportunityProcessor {
    public static List<OpportunityWrapper> getOpportunityWrappedRecords() {
        List<OpportunityWrapper> opportunityWrapperData = new List<OpportunityWrapper>();
        List<Opportunity> opportunityData = OpportunityDomain.getOpportunityRecords();
        for(Opportunity opportunity : opportunityData) {
            opportunityWrapperData.add(new OpportunityWrapper(opportunity));
        }
        return opportunityWrapperData;
    }
}