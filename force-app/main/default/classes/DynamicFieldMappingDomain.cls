/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Satish Yadav
* Ticket Number:AVEBLOG52
--------------------------------------------------------------------
* Blog: Dynamic Field Mapping
--------------------------------------------------------------------
* Purpose/ Methods: This is Class Will return Custom metadata type field and List of Contact
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Satish yadav       27/08/2023     Initial Development
***********************************************************************/
public class DynamicFieldMappingDomain {

    /**
     * Method is used to return source and Target field from fieldMapping custom metadata type.
     * @param Id 
     * return List of FieldMapping__mdt
    */
    public static List<FieldMapping__mdt> mapContactToAccount() {
        // Directly return the result of the SOQL query
        return [
            SELECT
                SourceField__c,
                TargetField__c
            FROM
                FieldMapping__mdt
        ];
    }

    /**
     * Method is used to return List of Contact .
     * @param Id 
     * return List of Contact
    */
    public static List<Contact> dynamicQuery(FieldMapping__mdt mappings, Id contactId) {
        String dynamicQuery = 'SELECT Id, FirstName, LastName, ' + mappings.SourceField__c +
            ' FROM Contact WHERE Id = :contactId LIMIT 1';
        return Database.query(dynamicQuery);
    }
}
