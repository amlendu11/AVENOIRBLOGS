public with sharing class ApexReplayDebugger {
    public static Integer calculateSum(List<Integer> numbers) {
        Integer sum = 0;
        for (Integer num : numbers) { 
            sum += num;
        }
        return sum;
    }

    public static void apexDebugger() {
        List<Integer> numbers = new List<Integer>{1, 2, 3, 4, 5};
        Integer sum = calculateSum(numbers);
        System.debug('Sum: ' + sum);
    }
}
