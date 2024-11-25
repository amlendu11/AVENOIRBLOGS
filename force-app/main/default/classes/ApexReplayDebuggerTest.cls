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
        List<Integer> numbers1 = new List<Integer>{1, 2, 3, 4, 5};
        Integer result1 = ApexReplayDebugger.calculateSum(numbers1);
        System.assertEquals(15, result1, 'The sum of {1, 2, 3, 4, 5} should be 15');

        List<Integer> numbers2 = new List<Integer>{-1, -2, 3, 4, 5};
        Integer result2 = ApexReplayDebugger.calculateSum(numbers2);
        System.assertEquals(9, result2, 'The sum of {-1, -2, 3, 4, 5} should be 9');

        List<Integer> numbers3 = new List<Integer>{};
        Integer result3 = ApexReplayDebugger.calculateSum(numbers3);
        System.assertEquals(0, result3, 'The sum of an empty list should be 0');

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
        Test.startTest();
        ApexReplayDebugger.getCalculation();
        Test.stopTest();
    }
}