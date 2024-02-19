/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG82
--------------------------------------------------------------------
*  Description : class to create opportunity record
--------------------------------------------------------------------
* Utility Test Class: CreateOpportunityTest.cls
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Anchal Agrawal       07/02/2024   Initial Development
***********************************************************************/
public class CreateOpportunity implements Queueable {
    Account account;
    public CreateOpportunity(Account account) {
        this.account = account;
    }

    /**
    * purpose : To execute Apex as an asynchronous job
    * @param - System.QueueableContext context
    * @return - NA
    **/
    public void execute(System.QueueableContext context) {
        Opportunity opportunity = OpportunityDomain.createAndInsertOpportunity(this.account);
    }
}