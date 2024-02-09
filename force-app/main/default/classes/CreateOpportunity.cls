public class CreateOpportunity implements Queueable {
    Account account;
    public CreateOpportunity(Account account) {
        this.account = account;
    }
    public void execute(System.QueueableContext context) {
        Opportunity opportunity = new Opportunity(
            Name = 'Test Opportunity',
            StageName = 'Qualification',
            CloseDate = System.today(),
            AccountId = this.account.Id
        );
        insert opportunity;
    }
}