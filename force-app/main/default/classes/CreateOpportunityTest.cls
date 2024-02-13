@isTest
public class CreateOpportunityTest {
	@isTest
    public static void createOpportunityTest() {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = 2;
        Account account = new Account(
        	Name = 'Test Account'
        );
        insert account;
        Test.startTest();
        	System.enqueueJob(new CreateOpportunity(account), asyncOptions);
        Test.stopTest();
        Integer size = [
        	SELECT
            	Id
            FROM
            	Opportunity
            WHERE
            	AccountId = :account.Id
       	].size();
        Assert.areEqual(1 , size);
    }
}