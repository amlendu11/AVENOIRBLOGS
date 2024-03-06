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

    @isTest
    static void testCompareBothNamesPresent() {
        StudentRecord student1 = new StudentRecord(System.Label.TestStudentName1, 
            System.Label.TestStudentPhone1
        );
        StudentRecord student2 = new StudentRecord(System.Label.TestStudentName2,
            System.Label.TestStudentPhone2
        );
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assert(result < 0, System.Label.Compare_AlphabeticalOrder);
    }

    /**
     * Purpose : Tests the comparison of two StudentRecord instances with one name blank. 
     * @Annotation : @isTest
     * @param : Na
    */

    @isTest
    static void testCompareFirstStudentNameBlank() {
        StudentRecord student1 = new StudentRecord(null, System.Label.TestStudentPhone1);
        StudentRecord student2 = new StudentRecord(System.Label.TestStudentName2,
            System.Label.TestStudentPhone2
        );
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(-1, result, System.Label.FirstNameBlank);
    }

    /**
     * Purpose : Tests the comparison of two StudentRecord instances with one phone blank. 
     * @Annotation : @isTest
     * @param : Na
    */

    @isTest
    static void testCompareSecondStudentNameBlank() {
        StudentRecord student1 = new StudentRecord(System.Label.TestStudentName1,
            System.Label.TestStudentPhone1
        );
        StudentRecord student2 = new StudentRecord(null, System.Label.TestStudentPhone2);
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(1, result, System.Label.SecondStudentNameBlank);
    }

    /**
    * Purpose : Tests the comparison of two StudentRecord instances with both name blank. 
    * @Annotation : @isTest
    * @param : Na
    */

    @isTest
    static void testCompareBothNamesBlank() {
        StudentRecord student1 = new StudentRecord(null, System.Label.TestStudentPhone1);
        StudentRecord student2 = new StudentRecord(null, System.Label.TestStudentPhone2);
        CompareByStudentName comparator = new CompareByStudentName();
        Integer result = comparator.compare(student1, student2);
        // Assert
        System.assertEquals(0, result, System.Label.BothNamesBlank);
    }
}
