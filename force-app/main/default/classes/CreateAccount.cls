/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
*  Description : class to set maximum stack depth and create account
* record
--------------------------------------------------------------------
* Utility Test Class: CreateAccountTest.cls
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       07/02/2024   Initial Development
***********************************************************************/
public class CreateAccount implements Queueable {

    /**
    * purpose : set maximum stack depth
    * @param - Integer maxDepth
    * @return - NA
    **/
    public static void callQueueable(Integer maxDepth) {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = maxDepth;
        System.enqueueJob(new CreateAccount(), asyncOptions);
    }

    /**
    * purpose : To execute Apex as an asynchronous job
    * @param - System.QueueableContext context
    * @return - NA
    **/
    public void execute(System.QueueableContext context) {
        Account account = AccountDomain.insertAccount(
            'Avenoir Technologies Pvt. Ltd.',
            '9987463210'
        );
        if(
            (System.AsyncInfo.hasMaxStackDepth() &&
            AsyncInfo.getCurrentQueueableStackDepth() <
            AsyncInfo.getMaximumQueueableStackDepth()) &&
            (!Test.isRunningTest())
        ) {
                System.enqueueJob(new CreateContact(account));
        }
    }
}