/********************************************************************
* (c) Copyright 2024 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Manish Kumar Gupta
* Ticket Number:AVEBLOG-108
--------------------------------------------------------------------
* Blog: Create a record using rest API(for Customer Community Plus users) using session id as a token.
--------------------------------------------------------------------
* Purpose/ Methods: Controller class of ApplicationForm LWC component.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME         DATE            DETAIL FEATURES
   1.0       Manish Kumar Gupta     08/17/2023      Initial Development
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
            Map<String, Object> responseBody = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            return (String) responseBody.get('id');
        } else {
            throw new CalloutException(res.getStatusCode() + ' - ' + res.getBody());
        }
    }

    @AuraEnabled
    public static String calloutExample(String objectApiName, String name, String isSelected) {
        Map<String, Object> recordFields = new Map<String, Object>{
            System.Label.APPLICATION_NAME_FIELD => name,
            System.Label.APPLICATION_SELECTION_FIELD => isSelected
        };
        return createRecord(objectApiName, recordFields);
    }
}