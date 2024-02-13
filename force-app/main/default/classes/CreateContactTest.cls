@isTest
public class CreateContactTest {
    @isTest
    public static void createContactTest() {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = 2;
        Account account = new Account(
        	Name = 'Test Account'
        );
        insert account;
        Test.startTest();
        	System.enqueueJob(new CreateContact(account), asyncOptions);
        Test.stopTest();
        Integer size = [
        	SELECT
            	Id
            FROM
            	Contact
            WHERE
            	AccountId = :account.Id
       	].size();
        Assert.areEqual(1 , size);
    }
}