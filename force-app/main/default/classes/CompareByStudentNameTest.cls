/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG79
--------------------------------------------------------------------------------
* Purpose : Test class for CompareByStudentName
--------------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0        Satish yadav        08/02/2024    Initial Development
*******************************************************************************/
@isTest
private class CompareByStudentNameTest {

    /**
     * Purpose : Tests the comparison of two StudentRecord instances with non-blank names. 
     * @Annotation : @isTest
     * @param : Na
    */

    @isTest static void testCompareBothNamesPresent() {
        StudentRecord student1 = new StudentRecord('Alice', '123456789');
        StudentRecord student2 = new StudentRecord('Bob', '987654321');
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assert(result < 0, 'Alice should come before Bob alphabetically');
    }

    /**
     * Purpose : Tests the comparison of two StudentRecord instances with one name blank. 
     * @Annotation : @isTest
     * @param : Na
    */

    @isTest static void testCompareFirstStudentNameBlank() {
        StudentRecord student1 = new StudentRecord(null, '123456789');
        StudentRecord student2 = new StudentRecord('Bob', '987654321');
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(-1, result,
            'A blank student name should be considered less than any non-blank name'
        );
    }

    /**
     * Purpose : Tests the comparison of two StudentRecord instances with one name blank. 
     * @Annotation : @isTest
     * @param : Na
    */

    @isTest static void testCompareSecondStudentNameBlank() {
        StudentRecord student1 = new StudentRecord('Alice', '123456789');
        StudentRecord student2 = new StudentRecord(null, '987654321');
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(1, result,
            'A non-blank student name should be considered greater than a blank name'
        );
    }

    @isTest static void testCompareBothNamesBlank() {
        StudentRecord student1 = new StudentRecord(null, '123456789');
        StudentRecord student2 = new StudentRecord(null, '987654321');
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(0, result,
            'Two blank student names should be considered equal'
        );
    }
}
