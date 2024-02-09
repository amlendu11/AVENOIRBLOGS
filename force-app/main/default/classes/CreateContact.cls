public class CreateContact implements Queueable {
    Account account;
    public CreateContact(Account account) {
        this.account = account;
    }
    public void execute(System.QueueableContext context) {
        Contact contact = new Contact(
            Lastname = 'Sharma',
            AccountId = this.account.Id
        );
        insert contact;
        System.debug('2');
        if(System.AsyncInfo.hasMaxStackDepth() &&
           AsyncInfo.getCurrentQueueableStackDepth() <
           AsyncInfo.getMaximumQueueableStackDepth()) {
        	System.enqueueJob(new CreateOpportunity(this.account));
         }
        else {
            System.debug('Max Depth has reached');
        }

    }
}