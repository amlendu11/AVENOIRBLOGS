/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Sourav Dash
* Ticket Number: AVEBLOG122
--------------------------------------------------------------------------------
* Purpose/ Methods: This is test helper class of QueryChunkingQueuableTest.
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Sourav Dash       25/11/2024   Initial Development
* ****************************************************************************/
@isTest
public class QueryChunkingQueuableTestHelper {

    public static void executeQueueable(Queueable job, Integer maxDepth) {
        AsyncOptions options = new AsyncOptions();
        options.MaximumQueueableStackDepth = maxDepth;
        // Execute the Queueable job within test context
        Test.startTest();
        System.enqueueJob(job, options);
        Test.stopTest();
    }
}