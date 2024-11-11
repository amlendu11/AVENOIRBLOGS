/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG111
--------------------------------------------------------------------------------
* Purpose/Methods: Return the required result.
* Class: ScheduleAccountSync.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Shiv K Chaudhary    09/11/2024   Initial Development
* ****************************************************************************/
public class ScheduleAccountSync implements Schedulable {

     /**
    * This method aims to schedule BatchToSyncExternalAccountRecord
    * @param context
    */
    public void execute(SchedulableContext context) {
        BatchToSyncExternalAccountRecord batchJob = new BatchToSyncExternalAccountRecord();
        Database.executeBatch(batchJob, 200);
    }
}
