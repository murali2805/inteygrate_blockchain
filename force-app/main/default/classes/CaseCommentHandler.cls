public class CaseCommentHandler {
    public Map<Id, User> userMap;
    
    public class fbmessengerReqBody 
    {
        
       public recipient recipient;
       public message message;
       public fbmessengerReqBody(){
           recipient = new recipient();
           message = new message();
       }
    
    }
    
    public class recipient 
    {
        public String id='';       
    }
    public class message 
    {
        public String text ='';
    } 
    
    public CaseCommentHandler(){
        
    }
    
    @future(callout=true)
    public static void sendTelegram(String message, String chatid,String origin){
        
        List<social_api__mdt> apiMapList = new List<social_api__mdt>();
        apiMapList = [SELECT api__c, access_token__c,content_type__c FROM social_api__mdt WHERE MasterLabel =: origin ];
        if(apiMapList.size()>0){

            HttpRequest req = new HttpRequest();
            req.setMethod('POST');
            
            String payload='';
            if(origin=='telegram'){
                req.setHeader('Content-Type',apiMapList[0].content_type__c);
                payload = 'text=' + message + '&chat_id='+chatid;
                
                req.setEndpoint(apiMapList[0].api__c+apiMapList[0].access_token__c+'/sendMessage');
            }
            else if(origin=='fbmessenger'){
                req.setHeader('Content-Type',apiMapList[0].content_type__c);
                fbmessengerReqBody frb = new fbmessengerReqBody();
                //fbmessengerReqBody.recipient rec = new recipient();
                //fbmessengerReqBody.message msg = new message();
                frb.recipient.id = chatid;
                frb.message.text = message;
                payload = json.serialize(frb);
                req.setEndpoint(apiMapList[0].api__c+'?access_token='+apiMapList[0].access_token__c);
            }
            else if(origin=='twitter'){
                payload='';
                req.setMethod('GET');
                req.setEndpoint(apiMapList[0].api__c+'?msg='+message+'&sender='+chatid);
            }
                
            Http http = new Http();
            req.setBody(payload);
            req.setHeader('Content-Length',String.valueOf(payload.length()));
            try {
     
                //Execute web service call here     
                HTTPResponse res = http.send(req);  
                
                //Helpful debug messages
                System.debug(res.toString());
                System.debug('STATUS:'+res.getStatus());
                System.debug('STATUS_CODE:'+res.getStatusCode());
                        
            } catch(System.CalloutException e) {
                //Exception handling goes here....
            }
        }   
    }
    
    public void afterInsert(List<CaseComment> newList){
        Set<Id> userId = new Set<Id>();
        
        for(CaseComment eachComment : newList){        
           userId.add(eachComment.LastModifiedById);
        }
        
        userMap = new Map<Id, User>([select id,Name from user where id in : userId]);
        List<Case> c = [SELECT Sender_ID__c,Origin FROM Case WHERE Id = :newList[0].ParentId];
        
        
       
        System.debug('\n------------------------------------------------------\n');
        for(CaseComment eachComment : newList){
            System.debug('Comment:' + eachComment.CommentBody);
            System.debug('SenderId:' + c[0].Sender_ID__c );
            //System.debug('Comment created by:' + userMap.get(eachComment.LastModifiedById).Name);
            //https://api.telegram.org/bot331162603:AAGJhoHlqNaqZ00bFqwoor6wwJ2bWCsVc6k/sendMessage
            if(eachComment.CreatedById!='00528000002D2HUAA0')
            sendTelegram(EncodingUtil.urlEncode(eachComment.CommentBody, 'UTF-8'), c[0].Sender_ID__c,c[0].origin.replaceAll('\\s+', '').toLowerCase());
            
        }
       
        System.debug('\n------------------------------------------------------\n');
    }
    
    public void afterUpdate(Map<Id, CaseComment> newMap,Map<Id,CaseComment> OldMap){
       
       
    }
    
    
    
    public void beforeDelete(List<CaseComment> oldList){
      
    }
}