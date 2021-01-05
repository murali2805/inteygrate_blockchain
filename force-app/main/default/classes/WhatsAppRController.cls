@RestResource(urlMapping='/whatsappr/*')
global class WhatsAppRController {

    @HttpPost
    global static void instCase(){
        
       JSONParser parser = JSON.createParser(restcontext.request.requestbody.tostring());
       TelegramJSON2Apex tj = new TelegramJSON2Apex(parser);
       
       /*List<Case> testCaseList = [SELECT id, Description FROM Case WHERE id='5000K00001Cfb0A'];
       testCaseList[0].Description = 'this:'+tj.message.text;
       update testCaseList;*/
       
       RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
       String origin = RestContext.request.params.get('origin');
       String senderId = String.valueOf(tj.message.chat.tid);
       String message = tj.message.text;
       String accessToken = 'test_token';//RestContext.request.params.get('token');

       RestContext.response.addHeader('Content-Type', 'application/json');
       
       if(accessToken!='test_token'){
           RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ '"Fail"' +',"Reason" : "'+ '"Invalid Access Token"' +'"}}');
       }
       else{
           List<Account> existingAccount = [SELECT id FROM Account WHERE sender_id__c =:senderId];
           if(existingAccount.size()>0){
              List<Case> existingOpenCases = [SELECT id,CaseNumber FROM Case WHERE Status != 'Closed' AND AccountId=:existingAccount[0].id ORDER BY LastModifiedDate DESC];
              if(existingOpenCases.size()>0){
                  CaseComment newComment = new CaseComment(parentid=existingOpenCases[0].id,CommentBody=message);
                  insert newComment;
                  
                  RestContext.response.responseBody = Blob.valueOf('{"data":{ "intent":'+ '"intent"' +',"Status":'+ '"Success"' +',"Case Number" : "'+ existingOpenCases[0].CaseNumber+'"}}');
              }
              else{
                  Case c = new Case(AccountId=existingAccount[0].Id,Status='New',Origin = origin,Subject = message,Description=message);
                  insert c;
                  List<Case> newCase = [SELECT CaseNumber FROM Case WHERE Id =:c.Id];
                  
                  if(newCase.size()>0)
                      RestContext.response.responseBody = Blob.valueOf('{"data":{"intent":'+ '"intent"' +',"Status":'+ '"Success"' +',"Case Number" : "'+ newCase[0].CaseNumber+'"}}');
                  else
                      RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ '"Fail"' +',"Reason" : "'+ '"Cannot Create Case"' +'"}}');
              }
           }
           else{
               Account a = new Account(Name=senderId,sender_id__c=senderId);
               insert a;
               Case c = new Case(AccountId=a.Id,Status='New',Origin = origin,Subject = message,Description=message);
               insert c;
               List<Case> newCase = [SELECT CaseNumber FROM Case WHERE Id =:c.Id];
               if(newCase.size()>0){
                       
                       RestContext.response.responseBody = Blob.valueOf('{"data":{"intent":'+ '"intent"' +', "Status":'+ 'Success' +',"Case Number" : "'+ newCase[0].CaseNumber+'"}}');
               }    
               else
                   RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ 'Fail' +',"Reason" : "'+ 'Cannot Create Case' +'"}}');
           }
    
           
           
       }
    }
    
    @HttpGet
    global static void logCase() {
    
        /* For instagram */
       /* 
       //RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
    
       String hub_challenge = RestContext.request.params.get('hub.challenge');
       if(hub_challenge!=null){
           RestContext.response.responseBody = Blob.valueOf(hub_challenge);
           return;
       }
       */
       
       
           
       
            
       RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
       String origin = RestContext.request.params.get('origin');
       String senderId = RestContext.request.params.get('senderid');
       String message = RestContext.request.params.get('message');
       String accessToken = RestContext.request.params.get('token');

       RestContext.response.addHeader('Content-Type', 'application/json');
       
       if(accessToken!='test_token'){
           RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ '"Fail"' +',"Reason" : "'+ '"Invalid Access Token"' +'"}}');
       }
       else{
           List<Account> existingAccount = [SELECT id FROM Account WHERE sender_id__c =:senderId];
           if(existingAccount.size()>0){
              List<Case> existingOpenCases = [SELECT id,CaseNumber FROM Case WHERE Status != 'Closed' AND AccountId=:existingAccount[0].id ORDER BY LastModifiedDate DESC];
              if(existingOpenCases.size()>0){
                  CaseComment newComment = new CaseComment(parentid=existingOpenCases[0].id,CommentBody=message);
                  insert newComment;
                  
                  RestContext.response.responseBody = Blob.valueOf('{"data":{ "intent":'+ '"intent"' +',"Status":'+ '"Success"' +',"Case Number" : "'+ existingOpenCases[0].CaseNumber+'"}}');
              }
              else{
                  Case c = new Case(AccountId=existingAccount[0].Id,Status='New',Origin = origin,Subject = message,Description=message);
                  insert c;
                  List<Case> newCase = [SELECT CaseNumber FROM Case WHERE Id =:c.Id];
                  
                  if(newCase.size()>0)
                      RestContext.response.responseBody = Blob.valueOf('{"data":{"intent":'+ '"intent"' +',"Status":'+ '"Success"' +',"Case Number" : "'+ newCase[0].CaseNumber+'"}}');
                  else
                      RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ '"Fail"' +',"Reason" : "'+ '"Cannot Create Case"' +'"}}');
              }
           }
           else{
               Account a = new Account(Name=senderId,sender_id__c=senderId);
               insert a;
               Case c = new Case(AccountId=a.Id,Status='New',Origin = origin,Subject = message,Description=message);
               insert c;
               List<Case> newCase = [SELECT CaseNumber FROM Case WHERE Id =:c.Id];
               if(newCase.size()>0){
                       
                       RestContext.response.responseBody = Blob.valueOf('{"data":{"intent":'+ '"intent"' +', "Status":'+ 'Success' +',"Case Number" : "'+ newCase[0].CaseNumber+'"}}');
               }    
               else
                   RestContext.response.responseBody = Blob.valueOf('{"data":{ "Status":'+ 'Fail' +',"Reason" : "'+ 'Cannot Create Case' +'"}}');
           }
    
           
           
       }
       
   
    }
    

    
}