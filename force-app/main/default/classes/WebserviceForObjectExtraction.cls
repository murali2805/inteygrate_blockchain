@RestResource(urlMapping='/objectextractor/*')
global class WebserviceForObjectExtraction {
    
    @HttpGet
    global static void queryLocator(){
    	RestContext.response.addHeader('Content-Type', 'application/json');
        RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
        String query = RestContext.request.params.get('query');
        String msg = 'Success';
        List<sObject> records = new List<sObject>();
        try{
            records = Database.query(query);
        }catch(Exception e){
            msg = e.getMessage() ;
        }
        
        if(msg=='Success')
            RestContext.response.responseBody = Blob.valueOf('{"data":{ "records":'+ JSON.serialize(records) +'"}}');
        else
            RestContext.response.responseBody = Blob.valueOf('{"data":{ "query":'+ query +',"msg":'+msg+'"}}');
    }
}