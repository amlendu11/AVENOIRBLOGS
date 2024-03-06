/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG79
--------------------------------------------------------------------------------
* Purpose : Test class for StudentRecord
--------------------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME        DATE         DETAIL FEATURES
   1.0        Satish yadav        08/02/2024    Initial Development
*******************************************************************************/
@isTest
public class StudentRecordTest {

    /**
    * Purpose : Tests the StudentRecord constructor to ensure it correctly assigns 
        student name and phone number to new instances.
    * @Annotation : @isTest
    * @param : Na
    */
    
    @isTest static void testStudentRecordConstructor() {
        String expectedStudentName = System.Label.ExpectedStudentName;
        String expectedPhone = System.Label.ExpectedPhoneNumber;
        StudentRecord testStudent = new StudentRecord(expectedStudentName, expectedPhone);
        // Assert: Verify that the fields are correctly assigned
        System.assertEquals(expectedStudentName, testStudent.studentName, 
            'The student name should match the expected value.'
        );
        System.assertEquals(expectedPhone, testStudent.Phone,
            'The phone number should match the expected value.'
        );
    }
}

