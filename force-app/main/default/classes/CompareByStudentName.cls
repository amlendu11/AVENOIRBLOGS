/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG79
--------------------------------------------------------------------------------
* Purpose/Methods: compare the StudentRecord by Name.
* Utility Test Class: CompareByStudentNameTest.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Satish Yadav      05/02/2024   Initial Development
* ****************************************************************************/
public with sharing class CompareByStudentName implements Comparator<StudentRecord> {

    /**
    * Constructor Purpose: Compares two StudentRecord instances based on the student's 
      name to determine their order. 
    * @param StudentRecord : studentOne
    * @param StudentRecord : studentTwo
    */

    public Integer compare(StudentRecord studentOne, StudentRecord studentTwo) {
        Integer returnValue = -1;
        if(String.isNotBlank(studentOne.studentName)) {
            returnValue = String.isBlank(studentTwo.studentName) ? 1 :
                studentOne.studentName.compareTo(studentTwo.studentName
            );
        }
        return returnValue;
    }
}   