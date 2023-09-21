/************************************************************************ 
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Pooja Ahuja
* Ticket Number:AVEBLOG57
------------------------------------------------------------------------
* Blog: CUSTOM PICKLIST FIELD EDITING IN LWC DATA TABLE .
------------------------------------------------------------------------
* Purpose/ Methods: This is processor class to process object data.
------------------------------------------------------------------------ 
* Version History: 
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES   
   1.0        Pooja Ahuja        11/09/2023    Initial Development   
***********************************************************************/
public class LeadProcessor {
   public static List<LeadWrapper> getLeadWrappedRecords() {
      List<LeadWrapper> leadWrapperData = new List<LeadWrapper>();
      List<Lead> leadData = LeadDomain.getLeadRecords();
      for(Lead lead : leadData) {
         leadWrapperData.add(new LeadWrapper(lead));
      }
      return leadWrapperData;
   }
}