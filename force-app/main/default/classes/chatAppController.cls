public without sharing class chatAppController{
    public String topic {get;set;}
    public String title {get;set;}
    public String changedTopic {get;set;}
    public List<PushTopic> topics {get;set;}
    public List<MyPushTopic> mytopics {get;set;}
    public Map<Id,String> initials {get;set;}
    
    public class MyPushTopic{
        public String Name {get;set;}
        public String Id{get;set;}
        public String LastModifiedDate{get;set;}
    }
    
    public chatAppController(){
    
        topics = new List<PushTopic>();
        mytopics = new List<MyPushTopic>();
        topics = [SELECT id,Name,LastModifiedDate FROM PushTopic ORDER BY LastModifiedDate DESC];
        System.debug('=================='+topics);
        
        initials = new Map<Id,String>();
        for( PushTopic topic : topics){
            MyPushTopic mytopic = new MyPushTopic();
            mytopic.id = topic.Id;
            mytopic.Name = topic.Name;
            mytopic.LastModifiedDate= String.valueOf(topic.LastModifiedDate);
            
            mytopics.add(mytopic);
            //initials.put(topic.id, topic.Name.substring(0,1).toUpperCase());
            initials.put(mytopic.id, mytopic.Name.substring(0,1).toUpperCase());
        }
        
        //topic = ApexPages.currentPage().getParameters().get('topic');
        topic = topics[0].Name;
        title = 'Salesforce Chat App';
        
    }
    
    public void changeTopic(){
        topic = changedTopic;
        System.debug('-----------------Called:'+topic);
    }
    
  
    public PageReference createPushTopic(){
    

        System.debug('Topic:'+topic);
        List<PushTopic> pushTopics = [SELECT id FROM PushTopic WHERE Name = :topic];
        System.debug('\n############### List:'+ pushTopics.isEmpty());
        
       
        if(pushTopics.isEmpty() && topic!=null && topic!=''){
            PushTopic pushTopic = new PushTopic();
            pushTopic.Name = topic;
            pushTopic.Query = 'SELECT Id, Name, message__c FROM chat__c WHERE Topic_Name__c =\'' + topic + '\'';
            pushTopic.ApiVersion = 36.0;
            pushTopic.NotifyForOperationCreate = true;
            pushTopic.NotifyForOperationUpdate = true;
            pushTopic.NotifyForOperationUndelete = true;
            pushTopic.NotifyForOperationDelete = true;
            pushTopic.NotifyForFields = 'Referenced';
            insert pushTopic;
            topics = [SELECT id,Name,LastModifiedDate FROM PushTopic];
            initials.put(pushTopic.id, pushTopic.Name.substring(0,1).toUpperCase());
        }
        
        PageReference orderPage = new PageReference('/apex/salesforce_chatapp');
        orderPage.setRedirect(true);
        return orderPage;
        
        
    }

}