public class CreateAccount implements Queueable {
    public static void callQueueable(Integer maxDepth) {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = maxDepth;
        System.enqueueJob(new CreateAccount(), asyncOptions);
    }
    public void execute(System.QueueableContext context) {
        try {
            Account account = new Account(
        		Name = 'Avenoir Technologies Pvt. Ltd.'
            );
            insert account;
            if(System.AsyncInfo.hasMaxStackDepth() &&
            AsyncInfo.getCurrentQueueableStackDepth() <
            AsyncInfo.getMaximumQueueableStackDepth()) {
                System.enqueueJob(new CreateContact(account));
            }
        }
        catch(Exception e) {
            throw new System.AsyncException(System.Label.Error_Message);
        }
    }
}