/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Diksha Dewangan
* Ticket Number: AVEBLOG-136
--------------------------------------------------------------------
* Description : Duplicate record check.
--------------------------------------------------------------------
* Utility Test Class: DuplicateCheckUtilityTest
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan       12/12/2024   Initial Development
***********************************************************************/
public class DuplicateCheckUtility {

    /**
    * This method aims to check duplicates for SObject Entry
    * @param List<SObject> objectsToCheck
    * @return List<Boolean> duplicateEntryFound
    */
    @InvocableMethod(
        label = System.Label.DUPLICATE_CHECK_MESSAGE
        description = 'Returns the List<Boolean> respectively'
    )
    public static List<Boolean> checkDuplicatesForSObjectEntry(
        List<SObject> objectsToCheck
    ) {
        Boolean isDuplicateThere = checkDuplicatesForRecord(
            new List<SObject>{ objectsToCheck[0] }
        );
        return new List<Boolean>{ isDuplicateThere };
    }

    /**
    * This method aims to check duplicates for SObject Record
    * @param List<SObject> objectsToCheck
    * @return Boolean isDuplicateThere
    */
    public static Boolean checkDuplicatesForRecord(
        List<SObject> objectsToCheck
    ) {
        Datacloud.FindDuplicatesResult[] results = Datacloud.FindDuplicates.findDuplicates(
            objectsToCheck
        );
        for (Datacloud.FindDuplicatesResult findDuplicateResultObj : results) {
            for (
                Datacloud.DuplicateResult duplicateResultObj :
                    findDuplicateResultObj.getDuplicateResults()
            ) {
                for (Datacloud.MatchResult matchResultObj : duplicateResultObj.getMatchResults()) {
                    for (Datacloud.MatchRecord matchRecord : matchResultObj.getMatchRecords()) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}