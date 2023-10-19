/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG57
------------------------------------------------------------------------
* Blog: CUSTOM PICKLIST FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is wrapper class to wrap object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        11/09/2023    Initial Development   
***********************************************************************/
public class LeadWrapper {
   @AuraEnabled
   public Lead leads {set; get;}
   public LeadWrapper(Lead lead) {
      this.leads = lead;
   }
}