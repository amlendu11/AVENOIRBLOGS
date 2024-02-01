public class QueueableJobTracker {
    public static Boolean checkQueuedJob(String jobName) {
      
        List<AsyncApexJob> jobList = [
            				   SELECT 
            					    Id 
            				   FROM 
            					    AsyncApexJob
            				   WHERE 
            					    JobType = 'Queueable'
                               AND 
            				        Status IN ('Queued', 'Processing') 
            				   AND 
            					    ApexClass.Name = :jobName
        					];
        return jobList.isEmpty();
    }
     public void enqueueUniqueJob(Integer value) {
        String jobName = 'QueueableJob'; 
        if (checkQueuedJob(jobName)) {
            System.enqueueJob(new QueueableJob(value));
        } 
        else {
            System.debug('Job is already in the queue, so can\'t be enqueued.');
        }
         
    }
  
}