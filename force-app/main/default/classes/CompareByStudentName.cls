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
    * @param StudentRecord : name1
    * @param StudentRecord : name2
    */

    public Integer compare(StudentRecord name1, StudentRecord name2) {
        Integer returnValue;
        if(String.isBlank(name1.studentName) && String.isBlank(name2.studentName)) {
            returnValue = 0;
        } 
        else {
            if(String.isBlank(name1.studentName)) { 
                returnValue = -1; 
            } 
            else if(String.isBlank(name2.studentName)) {
                returnValue = 1;
            }
            else {
                returnValue = name1.studentName.compareTo(name2.studentName);
            }
        }
        return returnValue;
    }
}