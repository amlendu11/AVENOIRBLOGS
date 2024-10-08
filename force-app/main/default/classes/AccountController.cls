/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Nikhil Mehra
* Ticket Number:AVEBLOG31
--------------------------------------------------------------------
* Blog: Fetching and Displaying Account and Contact Data in a Lightning Web Component
--------------------------------------------------------------------
* Purpose/ Methods: This is controller class of AccounttoDisplay.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Nikhil Mehra       08/17/2023      Initial Development
   1.1       Diksha Dewangan      22/06/2024    Added getAccounts
   2.0       Akash Kumar        29/06/2024      Added getAccountRecord
***********************************************************************/
public with sharing class AccountController {
   @AuraEnabled(cacheable=True)
   //Get Account Records
   public static List<AccountWrapper> getAccountList() {
      return AccountProcessor.getdomain();
	}

   @AuraEnabled(cacheable=true)
   public static List<AccountWrapper> getAccounts() {
      return AccountProcessor.getWrappedAccounts();
   }
   
   /**
   * This method aims to return Account record
   * @param String
   * @return AccountWrapper  
   */
   @AuraEnabled
   public static AccountWrapper getAccountRecord(String recordId) {
      return AccountProcessor.getProcessedRecord(recordId);
   }
}