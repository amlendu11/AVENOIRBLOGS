/********************************************************************
* (c) Copyright 2025 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Manish Kumar Gupta
* Ticket Number:AVEBLOG-108
--------------------------------------------------------------------
* Blog: Create a record using rest API(for Customer Community Plus users) using session id as a token.
--------------------------------------------------------------------
* Purpose/ Methods: Controller class of ApplicationForm LWC component.
--------------------------------------------------------------------
* Pre-Deployment Steps: Enable Digital Experience, Enable Allow using External Profiles for Self Registration,
    and a Role must be assigned to the current User of your org.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME         DATE            DETAIL FEATURES
   1.0       Manish Kumar Gupta     24/12/2024      Initial Development
   1.1       Manish Kumar Gupta     08/01/2025      CC: 100% | Added Test Class and Code Coverage, remove calloutExample parameter from String to Boolean
***********************************************************************/
public with sharing class ApplicationFormContoller {

    /**
     * Creates a record in Salesforce using the REST API.
     *
     * @param sObjectName The API name of the Application to create.
     * @param recordData A map of field names and values for the new Application.
     * @return The ID of the newly Application record.
     * @throws CalloutException If there is an issue with the HTTP request.
     */
    public static String createRecord(String sObjectName, Map<String, Object> recordData) {
        String baseUrl = System.URL.getOrgDomainUrl().toExternalForm();
        String restEndpoint = baseUrl + '/services/data/v57.0/sobjects/' + sObjectName;
        String requestBody = JSON.serialize(recordData);
        HttpRequest req = new HttpRequest();
        req.setEndpoint(restEndpoint);
        req.setMethod('POST');
        req.setHeader('Authorization', 'Bearer ' + UserInfo.getSessionId());
        req.setHeader('Content-Type', 'application/json');
        req.setBody(requestBody);
        Http http = new Http();
        HttpResponse res = http.send(req);
        if (res.getStatusCode() == 201) {
            return (String) res.getBody();
        } else {
            throw new CalloutException(res.getStatusCode() + ' - ' + res.getBody());
        }
    }

    @AuraEnabled
    public static String calloutExample(String objectApiName, String name, Boolean isSelected) {
        Map<String, Object> recordFields = new Map<String, Object>{
            System.Label.APPLICATION_NAME_FIELD => name,
            System.Label.APPLICATION_SELECTION_FIELD => isSelected
        };
        return createRecord(objectApiName, recordFields);
    }
}