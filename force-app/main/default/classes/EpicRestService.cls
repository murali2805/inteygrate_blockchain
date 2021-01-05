@RestResource(urlMapping='/epicrestservice/*')
global class EpicRestService {
  @HttpPost
    global static void epicPost(){
      
        JSONParser parser = JSON.createParser(restcontext.request.requestbody.tostring());
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        String code= RestContext.request.params.get('code');
        RestContext.response.responseBody = Blob.valueOf('{"data":'+code+'}');
    } 
    
    @HttpGet
    global static void epicGet(){
        
        RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        String code= RestContext.request.params.get('code');
        
        
        // Instantiate a new http object
        Http h = new Http();
    
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://uscdi.epic.com/interconnect-uscdi-oauth/oauth2/token');
        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        
        String clientId = '64f88977-08cd-4361-a02e-cf1132280a31';
        String redirect_uri = 'https://inteygrate-developer-edition.ap6.force.com/muralidhar/services/apexrest/epicrestservice';
        String payload = 'client_id='+EncodingUtil.urlEncode(clientId,'UTF-8')+'&code='+EncodingUtil.urlEncode(code,'UTF-8')+'&state='+EncodingUtil.urlEncode('abc123','UTF-8')+'&grant_type=authorization_code'+'&redirect_uri='+EncodingUtil.urlEncode(redirect_uri ,'UTF-8');
        req.setBody(payload);
        
    
        // Send the request, and return a response
        HttpResponse res = h.send(req);
        
        String jsonstr = '{"data":{"access_token": "L2Z_oY4fayEhG2OV6LD306H5KMNmEH1q3KY9N3nAwW3xK_3kcupcsFl1djHKVUjwe9ytuADHPHMwJ0w0SsOQUfLfHbo4DjmJFNhptZpMs6FEWOzVoAq--xp_sYeMCXa_"}}';
        JSONParser parser = JSON.createParser(res.getBody());
        String access_token='';
        while (parser.nextToken() != null) {
            if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) && 
                (parser.getText() == 'access_token')) {
                
                parser.nextToken();
                access_token= parser.getText();
            }
        }
        
        HttpRequest req2 = new HttpRequest();
        req2.setEndpoint('https://uscdi.epic.com/interconnect-uscdi-oauth/api/FHIR/DSTU2/DiagnosticReport?patient=T81lum-5p6QvDR7l6hv7lfE52bAbA2ylWBnv9CZEzNb0B');
        req2.setMethod('GET');
        req2.setHeader('Content-Type', 'application/json');
        req2.setHeader('Authorization', 'Bearer '+access_token);
        HttpResponse res2 = h.send(req2);
        
        //--RestContext.response.addHeader('Content-type', 'text/html; charset=utf-8');
        RestContext.response.responseBody = Blob.valueOf('{"data":'+res2.getBody()+'}');
        //--RestContext.response.responseBody = Blob.valueOf('<html><head></head><body><h1>Hello World!</h1><hr/><p>WE DID IT!!</p></body></html>');
        
        /*
        PageReference newFloodOnlyUrl = new PageReference('https://healthcare-demo.crm8.dynamics.com//WebResources/new_EpicHTML');
        newFloodOnlyUrl.setRedirect(true);
        return newFloodOnlyUrl ;
        */
        
        
    }
}