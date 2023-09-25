/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG57
------------------------------------------------------------------------
* Blog: CUSTOM PICKLIST FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is controller class to get object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        11/09/2023    Initial Development   
***********************************************************************/
public class LeadController {

   @AuraEnabled(cacheable=true)
   public static List<LeadWrapper> getAllLeads() {
      return LeadProcessor.getLeadWrappedRecords();
   }
    
   @AuraEnabled
   public static void saveDraftValues(Object data) {
      List<Lead> listOfLeads = (List<Lead>) JSON.deserialize(JSON.serialize(data), List<Lead>.class);
      update listOfLeads;
   }
}