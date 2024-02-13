public class CreateAccount implements Queueable {
    public static void callQueueable(Integer maxDepth) {
        AsyncOptions asyncOptions = new AsyncOptions();
        asyncOptions.MaximumQueueableStackDepth = maxDepth;
        System.enqueueJob(new CreateAccount(), asyncOptions);
    }
    public void execute(System.QueueableContext context) {
        Account account = new Account(
            Name = 'Avenoir Technologies Pvt. Ltd.'
        );
        insert account;
        if(
            (System.AsyncInfo.hasMaxStackDepth() &&
            AsyncInfo.getCurrentQueueableStackDepth() <
            AsyncInfo.getMaximumQueueableStackDepth()) &&
            (!Test.isRunningTest())
        ) {
                System.enqueueJob(new CreateContact(account));
        }
    }
}