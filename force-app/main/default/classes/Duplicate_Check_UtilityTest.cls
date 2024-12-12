@isTest
public class Duplicate_Check_UtilityTest {

    @isTest
    static void checkDuplicatesForSObjectEntryWithNoDuplicates() {
        List<SObject> testRecords = new List<SObject>();
        Account account = new Account(Name = 'Test Account');
        testRecords.add(account);
        Test.startTest();
        List<Boolean> results = Duplicate_Check_Utility.checkDuplicatesForSObjectEntry(testRecords);
        Test.stopTest();
        System.assertEquals(1, results.size());
        System.assertEquals(false, results[0]);
    }

    @isTest
    static void checkDuplicatesForSObjectEntrWithDuplicates() {
        Account account1 = new Account(
            Name = 'Duplicate Account',
            BillingStreet = '123 Dup St',
            BillingCity = 'DuplicateCity'
       	);
        Account account2 = new Account(
            Name = 'Duplicate Account',
            BillingStreet = '123 Dup St',
            BillingCity = 'DuplicateCity'
        );
        insert account1;
        Test.startTest();
        List<Boolean> results = Duplicate_Check_Utility.checkDuplicatesForSObjectEntry(
            new List<SObject> { account2 }
        );
        Test.stopTest();
        System.assertEquals(1, results.size());
        System.assertEquals(true, results[0]);
    }
}