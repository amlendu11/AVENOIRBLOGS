@isTest
private class AccountRecordSortingTest {
   @isTest
    static void testAccountRecordsSortedByName() {
        // Creating test data
        AccountRecord account1 = new AccountRecord('John Doe', '123-456-7890', '123 Main St');
        AccountRecord account2 = new AccountRecord('Alice Smith', '456-789-0123', '456 Elm St');
        AccountRecord account3 = new AccountRecord('Bob Johnson', '789-012-3456', '789 Oak St');
       // Adding records to a list
        List<AccountRecord> accounts = new List<AccountRecord>{account1, account2, account3};
        // Sorting the list by name
        accounts.sort();
       // Asserting the order of sorted accounts by name
        System.assertEquals('Alice Smith', accounts[0].getName(), 'The first account should be Alice Smith after sorting.');
        System.assertEquals('Bob Johnson', accounts[1].getName(), 'The second account should be Bob Johnson after sorting.');
        System.assertEquals('John Doe', accounts[2].getName(), 'The third account should be John Doe after sorting.');
    }
}
