public class Duplicate_Check_Utility {

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
            for (Datacloud.DuplicateResult duplicateResultObj : findDuplicateResultObj.getDuplicateResults()) {
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