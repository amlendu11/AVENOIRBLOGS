public class QueueableJob implements Queueable {
    private Integer value;
    public QueueableJob(Integer value) {
        this.value = value;
    }
    Account newAccount = new Account();
    
    public void execute(QueueableContext context) {
        newAccount.Name = 'Ambujaj'+ value;
        insert newAccount;
        System.debug('Executed unique job ');
       
    }

}