/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Shiv Kumar Chaudhary
* Ticket Number:AVEBLOG11
--------------------------------------------------------------------
* Blog: ACTION FUNCTION IN VISUALFORCE PAGE SALESFORCE.
--------------------------------------------------------------------
* Purpose/ Methods: This is controller class of ActionFunctionVFPage.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Shiv Kumar Chaudhary 4/19/2023   Initial Development
***********************************************************************/
public class AccountCustomController {
    public Account newAccountToInsert{get; set;}
    
    /**
    * This method aims to initialize newAccountToInsert
    * @param N/A
    * @return N/A
    */
    public AccountCustomController() {
        newAccountToInsert = new Account();
    }
    
    /**
    * This method aims to insert Account
    * @param N/A
    * @return PageReference
    */
    public PageReference calledFromVFPage() {
        String name = System.currentPageReference().getParameters().get('name');
        String phone = System.currentPageReference().getParameters().get('phone');
        newAccountToInsert = AccountDomain.insertAccount(name, phone);
        PageReference pageReference = new PageReference('/' + newAccountToInsert.id);
        pageReference.setRedirect(true);
        return pageReference ;
    }
}