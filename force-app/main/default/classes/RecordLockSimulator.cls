public class RecordLockSimulator implements Queueable {
    private Id accountId;

    // Constructor to pass accountId to the queueable job
    public RecordLockSimulator(Id accountId) {
        this.accountId = accountId;
    }

    public void execute(QueueableContext context) {
        // Lock the account record for update
        Account acc = [SELECT Id, Name FROM Account WHERE Id = :accountId FOR UPDATE];
        acc.Name = 'Updated by Process';

        // Simulate delay using a loop (to replace System.sleep)
        for (Integer i = 0; i < 1000000; i++) {
            Integer x = i;
        }

        // Update the account record after the simulated delay
        update acc;
    }
}
