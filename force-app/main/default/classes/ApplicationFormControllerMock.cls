/********************************************************************
* (c) Copyright 2025 Avenoir Technologies Pvt. Ltd. All rights reserved.
* Created by: Manish Kumar Gupta
* Ticket Number:AVEBLOG-108
--------------------------------------------------------------------
* Blog: Create a record using rest API(for Customer Community Plus users) using session id as a token.
--------------------------------------------------------------------
* Purpose/ Methods: Mock Callout Class to test ApplicationFormController class.
--------------------------------------------------------------------
* Pre-Deployment Steps: Enable Digital Experience, Enable Allow using External Profiles for Self Registration,
    and a Role must be assigned to the current User of your org.
--------------------------------------------------------------------
* Version History:
* VERSION    DEVELOPER NAME         DATE            DETAIL FEATURES
   1.0       Manish Kumar Gupta     08/01/2025      Initial Development
***********************************************************************/
@IsTest
public class ApplicationFormControllerMock implements HttpCalloutMock {
    private Integer statusCode;
    private String responseBody;

    public ApplicationFormControllerMock(Integer statusCode, String responseBody) {
        this.statusCode = statusCode;
        this.responseBody = responseBody;
    }

    public HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setStatusCode(statusCode);
        res.setBody(responseBody);
        return res;
    }
}