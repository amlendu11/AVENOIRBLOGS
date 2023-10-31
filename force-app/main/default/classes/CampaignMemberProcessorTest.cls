@isTest
public class CampaignMemberProcessorTest {

    @testSetup
    static void setupTestData() {
        // Create a Test Lead
        Lead testLead = new Lead(FirstName = 'Test', LastName = 'Lead', Company = 'Avenoir');
        insert testLead;

        // Create a Test Campaign
        Campaign testCampaign = new Campaign(Name = 'Test Campaign');
        insert testCampaign;

        // Create a CampaignMember associating the Test Lead with the Test Campaign
        CampaignMember testCampaignMember = new CampaignMember(
            CampaignId = testCampaign.Id,
            LeadId = testLead.Id
        );
        insert testCampaignMember;
    }

    @isTest
    static void testGetCampaignMembers() {
        // Perform any additional setup if needed
        List<Lead> testLeads = [
            SELECT
                Id
            FROM
                Lead 
            LIMIT 1
        ];
        List<CampaignMember> result = CampaignMemberProcessor.getCampaignMembers(testLeads[0].Id);
        System.assertEquals(1, result.size());
    }

    @isTest
    static void testChildRecordDetailsQueryHelper() {
        // The records created in the @TestSetup method are accessible here
        List<Lead> leads = [
            SELECT
                Id,
                LastName
            FROM
                Lead
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
        List<sObject> result = CampaignMemberProcessor.childRecordDetailsQueryHelper(
            'CampaignMember',
            testLead.Id,
            'Lead'
        );

        // Verify the results
        System.assertEquals(1, result.size());
        SObject retrievedRecord = result[0];
        System.assertEquals(testCampaignMember.CampaignId, retrievedRecord.get('CampaignId'));
        // Verify other fields based on your field set configuration

        // Test an exception scenario
        try {
            result = CampaignMemberProcessor.childRecordDetailsQueryHelper(
                'InvalidApiName', // Provide an invalid childApiName to trigger an exception
                testLead.Id,
                'Lead'
            );
        } catch(exception e) {
            System.assert(e instanceof AuraHandledException);
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
    }
}
