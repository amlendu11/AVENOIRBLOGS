public class ErrorHandlingDemo {
    public static void simulateLimitError(List<Account> newAccounts) {
       // Simulating an unhandled exception
        Integer result = 1 / 0;  // This will trigger a divide by zero exception
    }
}