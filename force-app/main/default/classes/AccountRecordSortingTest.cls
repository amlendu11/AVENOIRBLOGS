@isTest
private class AccountRecordSortingTest {
    @isTest
    static void testSorting() {
        List<AccountRecord> accountList = new List<AccountRecord>();
        accountList.add(new AccountRecord('Account C', '123-456-7890', 'Billing St C'));
        accountList.add(new AccountRecord('Account A', '987-654-3210', 'Billing St A'));
        accountList.add(new AccountRecord('Account B', '555-555-5555', 'Billing St B'));
        
        // Sort using the custom compareTo() method
        accountList.sort();
        // Verify list sort order.
        System.assertEquals('Account A', accountList[0].Name);
        System.assertEquals('Account B', accountList[1].Name);
        System.assertEquals('Account C', accountList[2].Name);
    }
}
