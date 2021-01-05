public class NewJira {
    public NewJira(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Atlassian_Jira/rest/api/2/issue/SJI-3');
        req.setMethod('GET');
        
        //req.setHeader('Authorization','OAuth {!$Credential.OAuthToken}');
        
        Http http = new Http();
        
        HTTPResponse res = http.send(req);
        System.debug(req.getHeader('Authorization'));
        System.debug(res.getBody());
    }
}