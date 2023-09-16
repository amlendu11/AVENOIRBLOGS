/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Satish Yadav
* Ticket Number:AVEBLOG52
--------------------------------------------------------------------
* Blog: Dynamic Field Mapping
--------------------------------------------------------------------
* Purpose/ Methods: This is Class of Dynamic Field Mapping between two object
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Satish yadav       27/08/2023     Initial Development
***********************************************************************/

public class DynamicFieldMappingController {

    /**
     * Method is used to return the String message
     * Annotation: @AuraEnabled with (Cacheable=True)
     * @param Id 
     * return DynamicFieldMappingWrapper
    */
    @AuraEnabled
    public static List<DynamicFieldMappingWrapper> mappedRecord(Id contactId) {
      return new DynamicFieldMappingProcessor().mapContactToAccount(contactId);
    }
}