global class JiraIntegration
{
    @future(callout=true)
    public static void CreateIssueinJIra(String objectType,String projectKey,String issueType,string summary,string description){
    new JiraIntegration(objectType,projectKey,issueType,summary,description);
    }

      public string summary;
      public string description;
      public JiraIntegration(){}
        //Change values in this class according to you JIRA/Salesforce coordinates.
         public String baseUrl = 'https://mihirs.atlassian.net/rest/api/2/issue/'; // Base URL of your JIRA instance
         public String username = 'shethmihir786@gmail.com';  // JIRA username
         public String password = 'direct@2016'; // JIRA password

     // Constructs Basic Http Authentication header from provided credentials
        public String authHeader(){
        Blob headerValue = Blob.valueOf(username+':'+password);
        return 'Basic ' + EncodingUtil.base64Encode(headerValue);
   		}
    
        public JiraIntegration(String objectType,String projectKey,String issueType,string summary,string description)
        {   
          HttpRequest req = new HttpRequest();
          Http http = new Http();
          req.setMethod('GET');

    //Set HTTPRequest header properties
        req.setHeader('Accept', 'application/json');
        req.setHeader('Content-Type','application/json');
        Blob headerValue = Blob.valueOf(username+':'+password);
        req.setHeader('Authorization','Basic '+ EncodingUtil.base64Encode(headerValue));
        req.setEndpoint(baseUrl);
        String CreateIssueinJIraJson= '{"fields": {"project":{"key": "TASK"},"summary":12345"'+ +'","description":"'+ +'" ,"issuetype":{"name": "Task"}}}';
        String JSONData = JSON.serializePretty(CreateIssueinJIraJson);   
       	req.setBody(CreateIssueinJIraJson);
		system.debug('after response....'+CreateIssueinJIraJson);
    	try
        {
        	//Execute web service call here      
    		HTTPResponse res = http.send(req);  
    		String ResponseJsonString = res.getBody();  
            system.debug('after res.getBody()....'+res.getBody());
        }              
        catch(System.CalloutException e)
        {
        	 System.debug('Callout error: '+ e);
		}  
    }
}