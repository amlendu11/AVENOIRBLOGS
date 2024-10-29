/*******************************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG-112
--------------------------------------------------------------------------------
* Description: class to get picklist values
--------------------------------------------------------------------------------
* Version History: (All changes and TA reworks should be entered as new row)
* VERSION     DEVELOPER NAME      DATE          DETAIL FEATURES
* 1.0         Diksha Dewangan   22/06/2024     Initial development
*******************************************************************************/
public class PicklistValuesProcessor {

    /*Purpose/Methods: This Method will return Map of String, Object fieldnameToPicklistValues
      @Param :  String objectApiName, List<String> fieldNames
      @return : Map<String, Object>
    */
    @AuraEnabled
    public static Map<String, Object> getPicklistValues(
            String objectApiName,
            List<String> fieldNames
    ) {
        Map<String, Object> fieldNameToOptions = new Map<String, Object>();
        Schema.SObjectType objectName = Schema.getGlobalDescribe().get(objectApiName) ;
        Schema.DescribeSObjectResult objectDescription = objectName.getDescribe() ;
        Map<String, Schema.SObjectField> fields = objectDescription.fields.getMap() ;
        for (String fieldName : fieldNames) {
            List<String> picklistValues = new List<String>();
            Schema.DescribeFieldResult fieldResult = fields.get(fieldName).getDescribe();
            List<Schema.PicklistEntry> getPicklistValues = fieldResult.getPicklistValues();
            for (Schema.PicklistEntry pickListVal : getPicklistValues) {
                picklistValues.add(pickListVal.getLabel());
            }
            fieldNameToOptions.put(fieldName, picklistValues);
        }
        return fieldNameToOptions;
    }
}