/********************************************************************
* (c) Copyright 2025 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Manish Kumar Gupta
* Ticket Number:AVEBLOG-108
--------------------------------------------------------------------
* Blog: Create a record using rest API(for Customer Community Plus users) using session id as a token.
--------------------------------------------------------------------
* Purpose/ Methods: Test Class to test ApplicationFormController class with added Code Coverage.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME         DATE            DETAIL FEATURES
   1.0       Manish Kumar Gupta     08/01/2025      CC: 100% | Initial Development
***********************************************************************/
@IsTest
public class ApplicationFormControllerTest {
    @TestSetup
    static void setupTestData() {
        Profile customerCommunityPlusProfile = [SELECT Id FROM Profile WHERE Name = 'Customer Community Plus User'];
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;
        Contact testUserContact = new Contact(LastName = 'Test Contact', AccountId = testAccount.Id);
        insert testUserContact;
        Test.startTest();
        User testUser = new User(
            Alias = 'testuser',
            Email = 'testuser@example.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'Test',
            LanguageLocaleKey = 'en_US',
            LocaleSidKey = 'en_US',
            ContactId = testUserContact.Id,
            ProfileId = customerCommunityPlusProfile.Id,
            TimeZoneSidKey = 'America/Los_Angeles',
            UserName = 'testuser885533@example.com'
        );
        insert testUser;
        Test.stopTest();
    }

    @IsTest
    static void testCreateApplicationSuccess() {
        Map<String, Object> applicationData = new Map<String, Object>{
            'Name' => 'Test Application',
            'Selected__c' => true
        };
        Test.startTest();
        HttpCalloutMock mock = new ApplicationFormControllerMock(201, '{"success":true,"errors":[]}');
        Test.setMock(HttpCalloutMock.class, mock);
        String response = ApplicationFormContoller.calloutExample('Application__c', (String) applicationData.get('Name'), (Boolean) applicationData.get('Selected__c'));
        Test.stopTest();
        System.assertEquals('{"success":true,"errors":[]}', response, 'Callout response success message must be true');
    }

    @IsTest
    static void testCreateApplicationFailure() {
        Map<String, Object> applicationData = new Map<String, Object>{
            'Name' => 'Test Application',
            'Is_Selected__c' => false
        };
        Test.startTest();
        HttpCalloutMock mock = new ApplicationFormControllerMock(400, '{"message":"Bad Request"}');
        Test.setMock(HttpCalloutMock.class, mock);
        try {
            String response = ApplicationFormContoller.calloutExample('Application__c', (String) applicationData.get('Name'), (Boolean) applicationData.get('Is_Selected__c'));
            System.assert(false, 'Exception was expected but not thrown.');
        } catch (CalloutException ex) {
            System.assertEquals('400 - {"message":"Bad Request"}', ex.getMessage(), 'Exception message should match.');
        }
        Test.stopTest();
    }
}
