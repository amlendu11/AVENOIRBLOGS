public class IntegrationHandler {
    public static Map<String, Object> callPostmanAPI() {
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        String endpoint = 'callout:Postman_API';
        req.setEndpoint(endpoint);
        req.setHeader('Username', '{!$Credential.Username}');
		req.setHeader('Password', '{!$Credential.Password}');
        req.setMethod('GET');
        HttpResponse response = http.send(req);
        Map<String, Object> results = new Map<String, Object>();
        if (response.getStatusCode() == 200) {
            results = (Map<String, Object>)JSON.deserializeUntyped(
                response.getBody()
            );
        }
        return results;
    }
}