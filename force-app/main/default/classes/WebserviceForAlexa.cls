@RestResource(urlMapping='/alexawebservice/*')
global class WebserviceForAlexa {
	@HttpPost
    global static void alexaPost(){
    	
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        RestContext.response.responseBody = Blob.valueOf('');
    } 
    
    @HttpGet
    global static void alexaGet(){
    	RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        //RestContext.response.responseBody = Blob.valueOf('Alexa Get');
        RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ 'Fail' +',"Reason" : "'+ 'Cannot Create Case' +'"}}');
    }
}