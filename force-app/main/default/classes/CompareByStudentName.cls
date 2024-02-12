/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG79
--------------------------------------------------------------------------------
* Purpose/Methods: compare the StudentRecord by Name.
* Utility Test Class: StudentRecordTest.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Satish Yadav      5/02/2024   Initial Development
* ****************************************************************************/
public with sharing class CompareByStudentName implements Comparator<StudentRecord> {

    //Here in this method, consider Name1 is the "instance" and Name2 is the "objectToCompareTo".
    public Integer compare(StudentRecord Name1, StudentRecord Name2) 
    {
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