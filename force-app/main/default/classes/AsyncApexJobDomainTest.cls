/*******************************************************************************
Avenoir Technologies Pvt. Ltd. All rights reserved.
Ticket Number: feature/AVE_0083
--------------------------------------------------------------------------------
Purpose : class for AsyncApexJobDomainTest
--------------------------------------------------------------------------------
Version History:
VERSION    DEVELOPER NAME        DATE          DETAIL FEATURES
 1.0       Navneet Soni       13/02/2024       Initial Development
*******************************************************************************/

@isTest
public class AsyncApexJobDomainTest {

    /**
     * purpose : This method aims to query the async apex job
     * @param : job type, status list and job name
     * Annotation : NA
     * return : Async apex job list
    */

    public static List<AsyncApexJob> fetchAsyncJobDetails(String jobType, List<String> status, String jobName) {
        return [
            	SELECT
            		Id
            	FROM
            		AsyncApexJob
            	WHERE
            		JobType = :jobType
            	AND
            		Status IN :status
            	AND
            		ApexClass.Name = :jobName
        ];
    }
}