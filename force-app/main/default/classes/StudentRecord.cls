/*******************************************************************************
* Avenoir Technologies Pvt. Ltd. All rights reserved.
* Ticket Number: AVEBLOG79
--------------------------------------------------------------------------------
* Purpose/Methods: Return the required result.
* Utility Test Class: StudentRecordTest.cls
--------------------------------------------------------------------------------
* Version History:
* VERSION     DEVELOPER NAME      DATE       DETAIL FEATURES
* 1.0         Satish Yadav      05/02/2024   Initial Development
* ****************************************************************************/
public with sharing class StudentRecord {
    public Id Id;
    public String studentName;
    public String Phone;
     
    /**
    * Constructor Purpose: Initializes a new instance of the StudentRecord class with a given 
      student name and phone number.
    * @param String : studentName
    * @param String :Phone
    */
    public StudentRecord(String studentName, String Phone) {
    this.studentName = studentName;
    this.Phone = Phone;
    }
}