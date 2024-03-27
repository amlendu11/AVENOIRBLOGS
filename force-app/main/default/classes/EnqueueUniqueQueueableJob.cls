/*******************************************************************************
Avenoir Technologies Pvt. Ltd. All rights reserved.
Ticket Number: feature/AVE_0083
--------------------------------------------------------------------------------
Purpose : class for enqueque the job
--------------------------------------------------------------------------------
Version History:
VERSION    DEVELOPER NAME        DATE          DETAIL FEATURES
 1.0        Navneet Soni       13/02/2024    Initial Development
*******************************************************************************/

public with sharing class EnqueueUniqueQueueableJob implements Queueable {
    private Integer value;
    Account newAccount = new Account();
    /**
     * purpose : This constructor aims to initialise the variable
     * @param : integer value
     * Annotation : NA
     * return : NA
    */

    public EnqueueUniqueQueueableJob(Integer value) {
        this.value = value;
    }

    /**
     * purpose : This method aims to insert new Account
     * @param : QueueableContext
     * Annotation : NA
     * return : NA
    */

    public void execute(QueueableContext context) {
        newAccount.Name = 'Ambujaj'+ value;
        insert newAccount;
    }
}