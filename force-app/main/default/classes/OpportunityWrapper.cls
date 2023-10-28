/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG61
------------------------------------------------------------------------
* Blog: CUSTOM LOOKUP FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is wrapper class to wrap object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        13/10/2023    Initial Development   
***********************************************************************/
public with sharing class OpportunityWrapper {

    @AuraEnabled
    public Opportunity opportunity {set; get;}

    public OpportunityWrapper(Opportunity opportunity) {
        this.opportunity = opportunity;
    }
}