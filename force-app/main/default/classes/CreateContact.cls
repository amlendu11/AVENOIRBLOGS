/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
*  Description : class to create contact record
--------------------------------------------------------------------
* Utility Test Class: CreateCreateTest.cls
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       07/02/2024   Initial Development
***********************************************************************/
public class CreateContact implements Queueable {
    Account account;
    public CreateContact(Account account) {
        this.account = account;
    }

    /**
    * purpose : To execute Apex as an asynchronous job
    * @param - System.QueueableContext context
    * @return - NA
    **/
    public void execute(System.QueueableContext context) {
        Contact contact = ContactDomain.createAndInsertContact(this.account);
        if(
            (System.AsyncInfo.hasMaxStackDepth() &&
            AsyncInfo.getCurrentQueueableStackDepth() <
            AsyncInfo.getMaximumQueueableStackDepth()) &&
            (!Test.isRunningTest())
        ) {
                System.enqueueJob(new CreateOpportunity(this.account));
        }
    }
}