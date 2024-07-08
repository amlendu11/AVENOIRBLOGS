/***********************************************************************
* (c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Satish Yadav
* Ticket Number: AVEBLOG91
------------------------------------------------------------------------
* Blog: How to use Apex replay debugger extension in SF for debugging.
* Test class : ApexReplayDebuggerTest
------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0       Satish Yadav       07/07/2024    Initial Development
***********************************************************************/
public with sharing class ApexReplayDebugger {

    /**
    * This method calculates the sum of all integers in a given list.
    * @param : numbers - List of integers to be summed up
    * @return : Integer - The sum of all integers in the list
    **/
    public static Integer calculateSum(List<Integer> numbers) {
        Integer sum = 0;
        for (Integer num : numbers) { 
            sum += num;
        }
        return sum;
    }

    /**
    * This method calculates the sum of a predefined list of integers and logs the result.
    * @param : None
    * @return : None
    **/
    public static void getCalculation() {
        List<Integer> numbers = new List<Integer>{1, 2, 3, 4, 5};
        Integer sum = calculateSum(numbers);
        System.debug('Sum: ' + sum);
    }
}
