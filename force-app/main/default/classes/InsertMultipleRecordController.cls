/* Blog: Insert Multiple Record with single backend call
--------------------------------------------------------------------
* Purpose/ Methods: This is Controller class for insertMultipleRecord.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Shiv K Chaudhary      3/08/2024    Initial Development
***********************************************************************/
public with sharing class InsertMultipleRecordController {
   @AuraEnabled
   public static void insertMultipleAccountRecord(String accounts){
      try {
         List<InsertMultipleAccountWrapper> accountsToInsert = (List<InsertMultipleAccountWrapper>)JSON.deserialize(
              accounts,
              List<InsertMultipleAccountWrapper>.class
         );
         AccountProcessor.processMultipleAccountToInsert(accountsToInsert);
      }
      catch (Exception e) {
         throw new AuraHandledException(e.getMessage());
      }
   } 
}
