/********************************************************************
* (c) Copyright 2023 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Anchal Agrawal
* Ticket Number: AVEBLOG99
--------------------------------------------------------------------
*  Description : Duplicate record check.
--------------------------------------------------------------------
* Utility Test Class: DuplicateCheckUtilityTest
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Diksha Dewangan       12/12/2024   Initial Development
***********************************************************************/
public class DuplicateCheckUtility {

    @InvocableMethod(
        label = 'Duplicate Check'
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