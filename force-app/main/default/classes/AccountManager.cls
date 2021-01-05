@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String req = request.requestURI;
        String acctId = req.substring(req.substring(0,req.lastIndexOf('/')).lastIndexOf('/')+1,req.lastIndexOf('/'));
        Account result =  [SELECT id,name,(select id,name from contacts)
                        FROM Account where id=:acctId];
        return result;
    }

}