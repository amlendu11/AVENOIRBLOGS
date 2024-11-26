/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Sourav Dash
* Ticket Number: AVEBLOG122
--------------------------------------------------------------------------------
* Purpose/ Methods: This is test class of QueryChunkingQueuable.
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Sourav Dash       25/11/2024   Initial Development
* ****************************************************************************/
@isTest
public class QueryChunkingQueuableTest {

    @testSetup
    static void setupTestData() {
        // Use TestDataFactory to create test data
        TestDataFactory.createAccounts(1000);
    }

    @isTest
    static void testQueryChunkingExecution() {
        // Create an instance of the Queueable class
        QueryChunkingQueuable queueableJob = new QueryChunkingQueuable();
        // Use QueryChunkingQueuableTestHelper to execute the queueable job
        QueryChunkingQueuableTestHelper.executeQueueable(queueableJob, 50);
        // Validate the total number of Account records processed
        Integer accountCount = [
            SELECT
                Count()
            FROM
                Account
        ];
        System.assertEquals(1000, accountCount, 'The number of Account records should match the test data.');
    }
}
