/***********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG50
------------------------------------------------------------------------
* Blog: Communicate to unrelated LWC components by NavigationMixing.
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan     24/08/2023   Initial Development
***********************************************************************/
@isTest
public with sharing class ChildObjectsControllerTest {

    @TestSetup
    static void setupTestData() {
        // Create test Lead and CampaignMember records
        Lead testLead = new Lead(LastName = 'Test Lead', Company = 'ABC');
        Insert testLead;
        Campaign testCampaign = new Campaign(Name = 'Test Campaign');
        Insert testCampaign;
        CampaignMember testCampaignMember = new CampaignMember(
            CampaignId = testCampaign.Id,
            LeadId = testLead.Id
        );
        Insert testCampaignMember;
    }

    @isTest
    static void testGetChildRecordDetails() {
        // The records created in the @TestSetup method are accessible here
        List<Lead> leads = [
            SELECT
                Id,
                LastName
            FROM
                Lead
        ];
        List<Campaign> testCampaign = [
            SELECT
                Id
            FROM
                Campaign
        ];
        List<CampaignMember> campaignMembers = [
            SELECT
                Id,
                CampaignId
            FROM
                CampaignMember
        ];

        // Access records using the collections you queried
        Lead testLead = leads[0];
        CampaignMember testCampaignMember = campaignMembers[0];

        // Call the method being tested
        List<String> childApiNames = new List<String>{ 'CampaignMember' };
        List<String> invalidChildApiNames = new List<String>{ 'Test' };
        Map<String, List<sObject>> result = ChildObjectsController.getChildRecordDetails(
            childApiNames,
            testLead.Id,
            'Lead'
        );

        // Verify the results
        System.assertEquals(1, result.size());
        List<sObject> resultCampaignMembers = result.get('CampaignMember');
        System.assertEquals(1, resultCampaignMembers.size());
        SObject retrievedRecord = resultCampaignMembers[0];
        System.assertEquals(testCampaign[0].Id, retrievedRecord.get('CampaignId'));
        // Verify other fields based on your field set configuration
        // Test an exception scenario

        try {
            result = ChildObjectsController.getChildRecordDetails(
                invalidChildApiNames, // Provide an invalid childApiName to trigger an exception
                testLead.Id,
                'Lead'
            );
        } catch (Exception e) {
            System.assert(e instanceof AuraHandledException);
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
    }
}
