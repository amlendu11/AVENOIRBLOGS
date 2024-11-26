/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Sourav Dash
* Ticket Number: AVEBLOG122
--------------------------------------------------------------------------------
* Purpose/Methods: Return the required result.
* Class: QueryChunkingQueuable.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Sourav Dash       25/11/2024   Initial Development
* ****************************************************************************/
public class QueryChunkingQueuable implements Queueable {

    private Database.Cursor locator;
    private Integer position;

    public QueryChunkingQueuable() {
        String query = 'SELECT Id, Name FROM Account';
        // Use the variable to initialize the query locator
        locator = Database.getCursor(query);
        position = 0;
    }

    public void execute(QueueableContext ctx) {
        List<Account> scope = locator.fetch(position, 200);
        position += scope.size();
        // Process the fetched records
        for(Account acc : scope){
            String name = acc.Name;
        }
        // If there are more records to process, re-enqueue the job
        if (position < locator.getNumRecords()) {
            System.enqueueJob(this);
        }
    }
}