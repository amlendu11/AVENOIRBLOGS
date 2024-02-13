public class CreateContact implements Queueable {
    Account account;
    public CreateContact(Account account) {
        this.account = account;
    }
    public void execute(System.QueueableContext context) {
        try {
            Contact contact = new Contact(
                Lastname = 'Sharma',
                AccountId = this.account.Id
            );
            insert contact;
            if(System.AsyncInfo.hasMaxStackDepth() &&
            AsyncInfo.getCurrentQueueableStackDepth() <
            AsyncInfo.getMaximumQueueableStackDepth()) {
                System.enqueueJob(new CreateOpportunity(this.account));
            }
        }
        catch(Exception e) {
            throw new System.AsyncException(System.Label.Error_Message);
        }

    }
}