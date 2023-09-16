/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Satish Yadav
* Ticket Number:AVEBLOG52
--------------------------------------------------------------------
* Blog: Dynamic Field Mapping
--------------------------------------------------------------------
* Purpose/ Methods: This is Class Will return required result.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Satish yadav       27/08/2023     Initial Development
***********************************************************************/
public class DynamicFieldMappingProcessor {

    /**
     * Method is used to do required process and return a wrapper message.
     * @param contactId 
     * return DynamicFieldMappingWrapper object
    */
    public List<DynamicFieldMappingWrapper> mapContactToAccount(Id contactId) {

        /**
        * This method Account record based on predefined field mappings. If the mapping and 
        * insertion are successful,a wrapper with a success message is returned
        * @param Id
        * @return A list of DynamicFieldMappingWrapper objects indicating the mapping status.
        */
        List<DynamicFieldMappingWrapper> resultWrapper = new List<DynamicFieldMappingWrapper>();
        List<Contact> contactRecords = new List<Contact>();
        Map<String, String> fieldMappingMap = new Map<String, String>();
        for (FieldMapping__mdt mapping : DynamicFieldMappingDomain.mapContactToAccount()) {
            if (mapping.TargetField__c != null && mapping.SourceField__c != null) {
                contactRecords = DynamicFieldMappingDomain.dynamicQuery(mapping, contactId);
                fieldMappingMap.put(mapping.TargetField__c, mapping.SourceField__c);
            }
        }
        try {
            if (!contactRecords.isEmpty()) {
            Account accountRecord = new Account(
                Name = contactRecords[0].FirstName + ' ' + contactRecords[0].LastName +
                ' MappedAccount'
            );
            // Map and copy data from Contact to Account dynamically using the map
            for (String targetField : fieldMappingMap.keySet()) {
                accountRecord.put(targetField, 
                contactRecords[0].get(fieldMappingMap.get(targetField)
                ));
            }
                insert accountRecord;
                String message = 'Mapping and insertion successful';
                resultWrapper.add(new DynamicFieldMappingWrapper(true, message));
                
            } 
        }
        catch (Exception ex) {
            String message = 'Mapping failed due to an error: ' + ex.getMessage();
            resultWrapper.add(new DynamicFieldMappingWrapper(false, message));
        }
        return resultWrapper;
    } 
}