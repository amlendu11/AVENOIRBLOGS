/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG112
--------------------------------------------------------------------
* Purpose/ Methods: This is test class of AccountController.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.1       Diksha Dewangan      08/07/2024    Added getAccounts
***********************************************************************/
@isTest
public class PicklistValuesControllerTest {

    @isTest
    static void testGetPicklistValues() {
        // Sample object and field names
        String objectApiName = 'Account';
        List<String> fieldNames = new List<String>{ 'Industry', 'Rating' };
        Map<String, Object> result = PicklistValuesController.getPicklistValues(
            objectApiName,
            fieldNames
        );
        System.assert(
            result.containsKey('Industry'),
            'Expected Industry field to be present in the result.'
        );
        System.assert(
            result.containsKey('Rating'),
            'Expected Rating field to be present in the result.'
        );
        List<String> industryValues = (List<String>)result.get('Industry');
        System.assertNotEquals(
            0,
            industryValues.size(),
            'Expected non-zero number of picklist values for Industry.'
        );
        List<String> ratingValues = (List<String>)result.get('Rating');
        System.assertNotEquals(
            0,
            ratingValues.size(),
            'Expected non-zero number of picklist values for Rating.'
        );
    }
}
