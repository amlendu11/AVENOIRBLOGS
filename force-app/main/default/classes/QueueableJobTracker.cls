/*******************************************************************************
Avenoir Technologies Pvt. Ltd. All rights reserved.
Ticket Number: feature/AVE_0083
--------------------------------------------------------------------------------
Purpose : class for identifying the unique jobs.
--------------------------------------------------------------------------------
Version History:
VERSION    DEVELOPER NAME        DATE          DETAIL FEATURES
 1.0        Navneet Soni       13/02/2024    Initial Development
*******************************************************************************/

public class QueueableJobTracker {
    /**
     * purpose : This method aims to check the job is unique or not 
     * @param : job name
     * Annotation : NA
     * return : boolean value
    */
    public static Boolean checkQueuedJob(String jobName) {
        List<AsyncApexJob> jobs = AsyncApexJobDomain.fetchAsyncApexJobDetails('Queueable', 'Queued', 'Processing', jobName);
        return jobs.isEmpty();
    }

    /**
     * purpose : This method aims to execute queueable job 
     * @param : integer value
     * Annotation : NA
     * return : NA
    */
    public void enqueueUniqueJob(Integer value) {
        String jobName = 'QueueableJob';
        if (checkQueuedJob(jobName)) {
            System.enqueueJob(new EnqueueUniqueQueueableJob(value));
        }
    }
}