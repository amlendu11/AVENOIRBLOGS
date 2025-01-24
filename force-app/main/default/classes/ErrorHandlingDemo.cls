public class ErrorHandlingDemo {
    public static void simulateLimitError() {
        // Exceeding SOQL query limit to trigger a governor limit exception
        for (Integer i = 0; i < 50001; i++) {
            List<Account> accs = [SELECT Id FROM Account LIMIT 1];
        }
    }
}
