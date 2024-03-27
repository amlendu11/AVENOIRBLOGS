/*******************************************************************************
Avenoir Technologies Pvt. Ltd. All rights reserved.
Ticket Number: feature/AVE_0083
--------------------------------------------------------------------------------
Purpose : class to test the code coverage
--------------------------------------------------------------------------------
Version History:
VERSION    DEVELOPER NAME        DATE          DETAIL FEATURES
 1.0       Navneet Soni       13/02/2024       Initial Development
*******************************************************************************/

@isTest
public class TestQueueable {

    /**
     * purpose : This method aims to test code coverage of the classes
     * @param : NA
     * Annotation : @isTest
     * return : NA
    */

    @isTest
    static void testEnqueueUniqueJob() {
        // Start test context
        Test.startTest();
        	new QueueableJobTracker().enqueueUniqueJob(10);
        Test.stopTest();
        List<AsyncApexJob> enqueuedJobs = AsyncApexJobDomainTest.fetchAsyncJobDetails('Queueable', new List<String>{'Queued', 'Processing'}, 'QueueableJob'); 
        System.assertEquals(0, enqueuedJobs.size(), 'No similar jobs are enqueued');
    }
}