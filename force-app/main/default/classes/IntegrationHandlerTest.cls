@isTest
public class IntegrationHandlerTest implements HttpCalloutMock{

    public static HTTPResponse respond(HTTPRequest req) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(200);
        response.setBody('{"authenticated": true}');
        return response;
    }
    
    @isTest
    public static void testCallPostmanAPI() {
        Test.setMock(HttpCalloutMock.class, new IntegrationHandlerTest());
        Map<String, Object> results;
        Test.startTest();
        results = IntegrationHandler.callPostmanAPI();
        Test.stopTest();
        System.assert(Boolean.valueOf(results.get('authenticated')), true);
    }
}