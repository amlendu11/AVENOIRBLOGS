/*******************************************************************************
Avenoir Technologies Pvt. Ltd. All rights reserved.
Ticket Number: feature/AVE_0083
--------------------------------------------------------------------------------
Purpose : class to test the code coverage
--------------------------------------------------------------------------------
Version History:
VERSION    DEVELOPER NAME        DATE          DETAIL FEATURES
 1.0        Navneet Soni       13/02/2024    Initial Development
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
    public static void testQueueable() {
        QueueableJobTracker queueJob = new QueueableJobTracker();
        Test.startTest();
        for (Integer i = 0; i < 3; i++) {
            queueJob.enqueueUniqueJob(i);
        }
        Test.stopTest();
    }
}