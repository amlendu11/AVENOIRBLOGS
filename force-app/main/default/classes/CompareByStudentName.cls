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
    * @param StudentRecord : Name1
    * @param StudentRecord : Name2
    */

    public Integer compare(StudentRecord Name1, StudentRecord Name2) {
        Integer returnValue;
        if(String.isBlank(Name1.studentName) && String.isBlank(Name2.studentName)) 
        {
            returnValue = 0;
        }
        else
        {
            if(String.isBlank(Name1.studentName)) 
            { 
                returnValue = -1; 
            } 
            else if(String.isBlank(Name2.studentName)) 
            {
                returnValue = 1;
            }
            else
            {
                //Since both values are not null or blank, using compareTo method itself
                returnValue = Name1.studentName.compareTo(Name2.studentName);
            }
        }
        return returnValue;
    }
}