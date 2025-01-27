trigger EmailException on Account (before insert) {
    ErrorHandlingDemo.simulateLimitError(Trigger.new);
}