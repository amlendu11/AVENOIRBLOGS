/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG57
------------------------------------------------------------------------
* Blog: CUSTOM PICKLIST FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is domain class to query object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        11/09/2023    Initial Development   
***********************************************************************/
global without sharing class LeadDomain {
    public static List<Lead> getLeadRecords() {
        return [
            SELECT 
                Id,
                Name, 
                Title, 
                Company, 
                Phone, 
                Email, 
                Status, 
                Owner.Alias, 
                LastViewedDate,
                CreatedDate, 
                OwnerId 
            FROM 
                Lead
        ];
    }
}