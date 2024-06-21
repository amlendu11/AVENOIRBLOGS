
/* Blog: Insert Multiple Record with single backend call
--------------------------------------------------------------------
* Purpose/ Methods: This is test class for InsertMultipleRecordController.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Shiv K Chaudhary      3/08/2024    Initial Development
***********************************************************************/
@isTest
public with sharing class InsertMultipleRecordControllerTest {
    @IsTest
    static void insertMultipleAccountRecordCase1() {
        List<InsertMultipleAccountWrapper> accounts = new List<InsertMultipleAccountWrapper>();
        accounts.add(new InsertMultipleAccountWrapper(
            'Account1',
            '232242332423',
            'er23rxcsd'
            )
        );
        
        Test.startTest();
        InsertMultipleRecordController.insertMultipleAccountRecord(JSON.serialize(accounts));
        Test.stopTest();
        Assert.isTrue(AccountDomain.getAccountRecords().size() == 1);
    }

    @isTest
    static void insertMultipleAccountRecordCase2() {
        List<InsertMultipleAccountWrapper> accounts = new List<InsertMultipleAccountWrapper>();
        accounts.add(new InsertMultipleAccountWrapper(
            null,
            '232242332423',
            'er23rxcsd'
            )
        );
        Test.startTest();
        try {
            InsertMultipleRecordController.insertMultipleAccountRecord(JSON.serialize(accounts));
        }
        catch (Exception e) {
        }
        Test.stopTest();
        Assert.isTrue(AccountDomain.getAccountRecords().size() == 0);
    }
}