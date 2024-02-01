@isTest
public class TestQueueable {
    @isTest
    public static void testQueueable() {
        QueueableJobTracker q= new QueueableJobTracker();
        Test.startTest();
        for(Integer i=0;i<3;i++) {
            q.enqueueUniqueJob(i);
        }
        Test.stopTest();

        
    }
}