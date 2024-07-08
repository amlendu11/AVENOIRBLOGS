/********************************************************************
* (c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Satish Yadav
* Ticket Number: AVEBLOG 91
--------------------------------------------------------------------
* Description: test class for ApexReplayDebugger.cls
--------------------------------------------------------------------
* Utility Test Class: NA
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
*   1.0     Satish Yadav         07/07/2024    Initial Development
***********************************************************************/
@isTest
public class ApexReplayDebuggerTest {

    /**
    * purpose : testing calculateSum of ApexReplayDebugger.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    static void testCalculateSum() {
        // Test case 1: Normal case with positive numbers
        List<Integer> numbers1 = new List<Integer>{1, 2, 3, 4, 5};
        Integer result1 = ApexReplayDebugger.calculateSum(numbers1);
        System.assertEquals(15, result1, 'The sum of {1, 2, 3, 4, 5} should be 15');

        // Test case 2: Normal case with mixed numbers
        List<Integer> numbers2 = new List<Integer>{-1, -2, 3, 4, 5};
        Integer result2 = ApexReplayDebugger.calculateSum(numbers2);
        System.assertEquals(9, result2, 'The sum of {-1, -2, 3, 4, 5} should be 9');

        // Test case 3: Edge case with an empty list
        List<Integer> numbers3 = new List<Integer>{};
        Integer result3 = ApexReplayDebugger.calculateSum(numbers3);
        System.assertEquals(0, result3, 'The sum of an empty list should be 0');

        // Test case 4: Edge case with a single number
        List<Integer> numbers4 = new List<Integer>{10};
        Integer result4 = ApexReplayDebugger.calculateSum(numbers4);
        System.assertEquals(10, result4, 'The sum of {10} should be 10');
    }

    /**
    * purpose : test ApexReplayDebugger.cls
    * @param : NA
    * @return : NA
    **/
    @isTest
    static void testGetCalculation() {
        // Test that getCalculation runs without error
        Test.startTest();
        ApexReplayDebugger.getCalculation();
        Test.stopTest();
        // We assume if there is no error, the method works fine for our simple case.
        // As we can't assert the debug log directly, we just ensure no exceptions are thrown.
    }
}