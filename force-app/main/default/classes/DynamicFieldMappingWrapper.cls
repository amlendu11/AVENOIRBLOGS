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

public with sharing class DynamicFieldMappingWrapper {
    @AuraEnabled
    public Boolean isSuccess { get; set; }
    @AuraEnabled
    public String message { get; set; }

    /**
     * Purpose : Constructor is used to wrap the Custom Message
     * @param : Boolean isSuccess, String message 
    */
    public DynamicFieldMappingWrapper() {
        this.isSuccess = false;
        this.message = '';
    }
    public DynamicFieldMappingWrapper(Boolean isSuccess, String message) {
        this.isSuccess = isSuccess;
        this.message = message;
    }
}