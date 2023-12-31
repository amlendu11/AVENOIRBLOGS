/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Nikhil Mehra
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Fetching and Displaying Account and Contact Data in a Lightning Web Component
--------------------------------------------------------------------
* Purpose/ Methods: This is Processor class.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Nikhil Mehra       08/17/2023      Initial Development
***********************************************************************/
public with sharing class AccountProcessor {
    public static List<AccountWrapper> getdomain() {
        List<AccountWrapper> processedData = new List<AccountWrapper>();
        for(Account acc : AccountDomainDisplay.getAccounts()) {
            processedData.add(new AccountWrapper(acc));
        }
        return processedData;
    }
}