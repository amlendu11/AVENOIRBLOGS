@isTest
public class createAccountTest {
	@isTest
    public static void callQueueableTest() {
        Test.startTest();
        	CreateAccount.callQueueable(1);
        Test.stopTest();
        Integer size = [
        	SELECT
            	Id
            FROM
            	Account
       	].size();
        Assert.areEqual(1 , size);
    }
}