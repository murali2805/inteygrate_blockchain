//https://inteygrate-developer-edition.ap6.force.com/muralidhar/services/apexrest/uber 
@RestResource(urlMapping='/uber/*')
global class UberMiddleware {

    
    @HttpGet
    global static void initOauth() {
    
      
       RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
       String referer = RestContext.request.params.get('referer');
       
       HttpRequest req = new HttpRequest();
       Http http = new Http();
       req.setMethod('GET');    
       req.setEndpoint('https://login.uber.com/oauth/v2/authorize?response_type=code&client_id=1KZQ_3P83UrP2VXxxEHnEGL9dd0F2O_z&scope=all_trips+profile+request+request_receipt&redirect_uri='+referer);
       HttpResponse res = http.send(req);
       System.debug(res.getBody());
 
       RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ referer +',"Reason" : "'+ '"Invalid Access Token"' +'"}}');
       
   
    }
    

    
}