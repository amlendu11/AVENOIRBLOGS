/*******************************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG-112
--------------------------------------------------------------------------------
* Description: class to get picklist values
* Utility Test Class: PicklistValuesControllerTest.cls
--------------------------------------------------------------------------------
* Version History: (All changes and TA reworks should be entered as new row)
* VERSION     DEVELOPER NAME      DATE          DETAIL FEATURES
* 1.0         Diksha Dewangan   22/06/2024     Initial development
*******************************************************************************/
public with sharing class PicklistValuesController {

    /*Purpose/Methods: This Method will return Map of String, Object fieldnameToPicklistValues
        @Param :  String objectApiName, List<String> fieldNames
        @return : Map<String, Object>
    */
    @AuraEnabled
    public static Map<String, Object> getPicklistValues(
            String objectApiName,
            List<String> fieldNames
    ) {
        Map<String, Object> picklistNameToValues = PicklistValuesProcessor.getPicklistValues(
            objectApiName,
            fieldNames
        );
        return picklistNameToValues;
    }
}