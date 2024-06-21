/* Blog: Insert Multiple Record with single backend call
--------------------------------------------------------------------
* Purpose/ Methods: This is Wrapper class.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Shiv K Chaudhary      3/08/2024    Initial Development
***********************************************************************/
public with sharing class InsertMultipleAccountWrapper {
    @AuraEnabled
    public String accountName;
    @AuraEnabled
    public String accountPhone;
    @AuraEnabled
    public String accountNumber;
    public InsertMultipleAccountWrapper(
        String accountName,
        String accountPhone,
        String accountNumber
    ) {
        this.accountName = accountName;
        this.accountNumber = accountNumber;
        this.accountPhone = accountPhone;
    }
}