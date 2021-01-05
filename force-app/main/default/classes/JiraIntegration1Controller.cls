public class JiraIntegration1Controller
{

      public List<JiraIssue__c> supportIssues {get;set;}
      public String issueKey{get;set;}
      
      string searchKey = '';
      
      public string username;
      public string password;
      public string lastbatchrun;
      
      public List<JiraIssue__c> getSupportIssues(){
          return supportIssues;
      }
      
      public List<SelectOption> size{get;set;}            
      public String selectedsize{get;set;}

      public Boolean isPreviousRequired{
        get {
               return (startAt>0);
        }
      }
      
      public Boolean isNextRequired{
        get {
               return (nextRequired );
        }
      }
      

      public integer startAt = 0;
      public integer maxResults= 10;
      public boolean nextRequired = true;
      
      public List<SelectOption> getSizes(){
          List<SelectOption> options = new List<SelectOption>();
          options.add(new SelectOption('10','10'));
          options.add(new SelectOption('20','20'));
          options.add(new SelectOption('25','25'));
          return options;
      }
       
      
      public void savePageSize(){
         maxResults = integer.valueof(selectedsize);
         sameAsJIC();
      }
            
       
      public class issue{
          public string expand;
          public fields fields;
          public string id;
          public string key;
          public string self;
          
      }
      public class fields{
          public project project;
          public string summary;
          /*public Datetime created;
          public Datetime updated;
          public issuetype issuetype;
          public priority priority;
          public product customfield_11600;
          public resolution resolution;
          public Datetime resolutiondate;
          public rootcause customfield_11100; 
          public Status status;
          public assignee assignee;
          public string comment; */
       }
       public class comment{
       public String self;  //http://www.example.com/jira/rest/api/2/issue/10010/comment/10000
        public String id;   
        public cls_author author;
        public String body; 
        public cls_updateAuthor updateAuthor;
        public String created;  
       public String updated;  
       public cls_visibility visibility;
       public comments comments;
    }
    public class comments {
    
        public String body; 
       }
    class cls_author {
        public String self; 
        public String name; 
        public String displayName;  
        public boolean active;
    }
    class cls_updateAuthor {
        public String self; 
        public String name; 
        public String displayName;  
        public boolean active;
    }
    class cls_visibility {
        public String type;
        public String value;  
        }  
      public class assignee{
          public Boolean active;
          public avatarUrl avatarUrls;
          public string displayName;
          public string emailAddress;
          public string key;
          public string name;
          public string self;
          public string timeZone;
      
      }
      
      public class Status{
          public string description;
          public string iconurl;
          public string id;
          public string name; //this should be referred for issuetype
          public string self;
      }
      
      public class resolution{
          public string description;
          public string id;
          public string name; //this should be referred for resolution
          public string self;
      }
      
      public class product{
          public string id;
          public string self;
          public string value;
      }
      
      public class rootcause{
          public string id;
          public string self;
          public string value;
      }
      
      public class issuetype{
          public string description;
          public string iconurl;
          public string id;
          public string name; //this should be referred for issuetype
          public string self;
          public Boolean subtask;
      }
      
       public class priority{
          public string iconurl;
          public string id;
          public string name; //this should be referred for priority
          public string self;
      }
      
      public class project{
          public avatarUrl avaraUrls;
          public string id;
          public string key;
          public string name;
          public projectCategory projectCategory;
          public string self;
      }
      
      public class avatarUrl{
          public string str1;
          public string str2;
          public string str3;
          public string str4;                    
      }
      
      public class projectCategory{
          public string description;
          public string id;
          public string name;
          public string self;
      }
      
      public void previous(){
          if(startAt > 0){
              startAt = startAt - (maxResults + 1);
              nextRequired = true;
          }
          sameAsJIC();

      }
      
      public void next(){
          if(nextRequired)
              startAt = startAt + maxResults + 1;
          sameAsJIC();
          if(supportIssues.size() < maxResults)
              nextRequired = false;
          else
              nextRequired = true;
      }
      
      public void searchByKey(){
         searchKey = issueKey;
         sameAsJIC();
      }
      
      
      public void sync(){
          List<JiraIssue__c> updateIssueList = new List<JiraIssue__c>();
          for(JiraIssue__c issue : supportIssues){
              if(issue.syncThisIssue__c == true){
                  JiraIssue__c[] issueIds = [SELECT id FROM JiraIssue__c WHERE Issue_Key__c = :issue.Issue_Key__c];
                  if(issueIds.size()> 0){
                      issue.id = issueIds[0].id ;
                  }
                  updateIssueList.add(issue);
                  issue.syncStatus__c = 2;
              }
          }
          try{
              upsert(updateIssueList);
          }catch (DmlException e){
              System.debug('Exception while upserting issues:'+e);
          }
          System.debug('########'+updateIssueList);
      }
      
      public void sync1(){
       List<JiraIssue__c> updateIssueList = new List<JiraIssue__c>();
          for(JiraIssue__c comment : supportIssues){
              if(comment.syncThisIssue__c == true){
                  JiraIssue__c[] issueIds = [SELECT id FROM JiraIssue__c WHERE Issue_Key__c = :comment.Issue_Key__c];
                  if(issueIds.size()> 0){
                      comment.id = issueIds[0].id ;
                  }
                  updateIssueList.add(comment);
                  comment.syncStatus__c = 2;
              }
          }
          try{
              upsert(updateIssueList);
          }catch (DmlException e){
              System.debug('Exception while upserting issues:'+e);
          }
          System.debug('########'+updateIssueList);
      }
      
      
      public void sameAsJIC(){

            Http http = new Http();
            HttpRequest req = new HttpRequest();
            
            string datecleansing = lastbatchrun.replace(' ','%20');
            string filter = 'updatedDate>'+'%27'+datecleansing.substring(0, datecleansing.length() - 3)+'%27';
            //string filter = 'status=closed%20and%20category%20=%27akritiv%20support%27';
            if(searchKey!='')
                filter = 'key='+searchKey;
            string fields =     'key,'+
                                'assignee,'+
                                'project,'+
                                'summary,'+
                                'created,'+
                                'updated,'+
                                'issuetype,'+
                                'priority,'+
                                'resolution,'+
                                'resolutiondate,'+
                                'status,'+
                                'comment';
                                
            System.debug('+++++++++++++++++++++++++++++++++++++Final URL:'+'https://mihirs.atlassian.net/rest/api/2/search?jql=&os_username=' + username + 
                            '&os_password=' + password +
                            '&fields=' + fields + 
                            '&startAt='+ startAt +
                            '&maxResults='+maxResults);
            
           
            req.setEndpoint('https://mihirs.atlassian.net/rest/api/2/search?jql=&os_username=' + username +  
                            '&os_password=' + password +
                            '&fields=' + fields + 
                            '&startAt='+ startAt +
                            '&maxResults='+maxResults);
            req.setMethod('GET');
            
            /*
            Blob headerValue = Blob.valueOf(username + ':' + password);
            String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
            req.setHeader('Authorization', authorizationHeader);
            req.setHeader('Content-Type', 'application/json');
            System.debug('Authorization Header:'+req.getHeader('Authorization'));
            System.debug('Decode:'+EncodingUtil.base64Decode('bXVyYWxpZGhhci5zYW1wYXRoaXJhbzpKdWx5QDIwMTQ=').toString());
            */
            
            HttpResponse res = http.send(req);
        
            // Log the JSON content
            System.debug('JSON Response: ' + res.getBody());
            
            String JSONContent = res.getBody();
            supportIssues = new List<JiraIssue__c>();
            //------------------------------------------------------------------------------------------
            JSONParser parserJira = JSON.createParser(JSONContent);
            while (parserJira.nextToken() != null) {
                // Start at the array of issues.
                if (parserJira.getCurrentToken() == JSONToken.START_ARRAY) {
                    while (parserJira.nextToken() != null) {
                        if ((parserJira .getCurrentToken() == JSONToken.START_OBJECT)){ 
                            issue jiraIssue = (issue)parserJira.readValueAs(issue.class);
                            System.debug('Key ' + jiraIssue.key);
                            System.debug('Project:' + jiraIssue.fields.project.key);
                            JiraIssue__c supportIssue = new JiraIssue__c();
                            supportIssue.Issue_Key__c = jiraIssue.key;
                            //Account[] acts = [SELECT id,Name, Site FROM Account WHERE Name= :jiraIssue.fields.project.key];
                            //if(acts.size()> 0){
                            //    supportIssue.Account_Name__c = acts[0].id ;
                            //}
                            
                            JiraIssue__c[] existingIssues = [SELECT id,
                                                                         Issue_Key__c,
                                                                         Summary__c
                                                                         //Created_Date__c,
                                                                         //Updated_Date__c,
                                                                         //Issue_Type__c,
                                                                         //Priority__c,
                                                                         //Assignee__c,
                                                                         //Product__c,
                                                                         //Resolution__c,
                                                                         //Resolved_Date__c,
                                                                         //Root_Cause__c,
                                                                         //Status__c,Comments__c
                                                                         FROM JiraIssue__c WHERE Issue_Key__c = :jiraIssue.key];
                                                          
                            supportIssue.Summary__c = jiraIssue.fields.summary;
                            //supportIssue.Comments__c = jiraIssue.fields.comment;
                            //supportIssue.Created_Date__c = jiraIssue.fields.created;
                            //supportIssue.Updated_Date__c = jiraIssue.fields.updated;
                            
                            //supportIssue.Issue_Type__c = jiraIssue.fields.issuetype.name;
                            //supportIssue.Priority__c = jiraIssue.fields.priority.name;
                            //supportIssue.Assignee__c = jiraIssue.fields.assignee.displayName;                            
                            
                            /*if(jiraIssue.fields.customfield_11600!=null)
                                supportIssue.Product__c = jiraIssue.fields.customfield_11600.value;
                                
                            if(jiraIssue.fields.resolution !=null)
                                supportIssue.Resolution__c = jiraIssue.fields.resolution.name;
                            else
                                supportIssue.Resolution__c = 'Unresolved';
                            
                            supportIssue.Resolved_Date__c = jiraIssue.fields.resolutiondate;

                            if(jiraIssue.fields.customfield_11100!=null)
                                supportIssue.Root_Cause__c = jiraIssue.fields.customfield_11100.value;
                            supportIssue.Status__c = jiraIssue.fields.status.name;
                            */

                            
                            //---------------- G E T  I D -----------------
                              JiraIssue__c[] issueIds = [SELECT id FROM JiraIssue__c WHERE Issue_Key__c = :supportIssue.Issue_Key__c];
                              if(issueIds.size()> 0){
                                  supportIssue.id = issueIds[0].id ;
                              }
                            //---------------------------------------------
                            
                            if(!(existingIssues.size()> 0)){
                                supportIssue.syncStatus__c = 0 ;
                            }
                            else if(compare(existingIssues[0],supportIssue))
                                supportIssue.syncStatus__c = 2 ;
                            else
                                supportIssue.syncStatus__c = 1 ;

//                            if(supportIssue.syncStatus__c == 0)
                            supportIssues.add(supportIssue);
                            
                        }
                    }
                }
            }

            //------------------------------------------------------------------------------------------          
      }
      
      public boolean compare(JiraIssue__c thisIssue,JiraIssue__c supportIssue){
          boolean flag = false;
          
          System.debug('//////////////////////////////////////////////////////////////////////');
          if(thisIssue.Summary__c == supportIssue.Summary__c) System.debug('Summary__c True');
          //if(thisIssue.Comments__c == supportIssue.Comments__c) System.debug('Comments__c True');
          //if(thisIssue.Updated_Date__c == supportIssue.Updated_Date__c) System.debug('Updated_Date__c True');
          //if(thisIssue.Issue_Type__c == supportIssue.Issue_Type__c) System.debug('Issue_Type__c True');
          //if(thisIssue.Priority__c == supportIssue.Priority__c) System.debug('Priority__c True');
          //if(thisIssue.Assignee__c == supportIssue.Assignee__c) System.debug('Assignee__c True');
          //if(thisIssue.Product__c == supportIssue.Product__c) System.debug('Product__c True');
          //if(thisIssue.Resolution__c == supportIssue.Resolution__c) System.debug('Resolution__c True');
          //if(thisIssue.Resolved_Date__c == supportIssue.Resolved_Date__c) System.debug('Resolved_Date__c True');
          //if(thisIssue.Root_Cause__c == supportIssue.Root_Cause__c) System.debug('Root_Cause__c True');
          //if(thisIssue.Status__c == supportIssue.Status__c) System.debug('Status__c True');
          System.debug('END //////////////////////////////////////////////////////////////////////');
          
          try{
             /* if(    (thisIssue.Summary__c.trim() == supportIssue.Summary__c.trim()) &&
                     (thisIssue.Comments__c.trim() == supportIssue.Comments__c.trim()) &&
                     (thisIssue.Updated_Date__c == supportIssue.Updated_Date__c) &&
                     (thisIssue.Issue_Type__c == supportIssue.Issue_Type__c) &&
                     (thisIssue.Priority__c == supportIssue.Priority__c) &&
                     (thisIssue.Assignee__c == supportIssue.Assignee__c) &&
                     (thisIssue.Product__c  == supportIssue.Product__c) &&
                     (thisIssue.Resolution__c  == supportIssue.Resolution__c)  &&
                     (thisIssue.Resolved_Date__c == supportIssue.Resolved_Date__c) &&
                     (thisIssue.Root_Cause__c == supportIssue.Root_Cause__c) &&
                     (thisIssue.Status__c == supportIssue.Status__c)
                 ) */
  			if(thisIssue.Summary__c.trim() == supportIssue.Summary__c.trim()) 
               {
                     flag = true;
               }
           }catch(Exception e){
               System.debug('!!!!!!!!!!Exception while comparison!!!!!!!!!!!!!!!');
           }
           //System.debug(deleteWhitespace(supportIssue.Assignee__c));
           System.debug('Difference-------------'+thisIssue.Summary__c.difference(supportIssue.Summary__c)+'::::'+thisIssue.Summary__c.replace(' ','#')+' vs. '+ supportIssue.Summary__c.replace(' ','#'));
           return flag;
      }
      
    
      public JiraIntegration1Controller() {
      
       
            Jira_Adapter__c[] jiraUsers = [SELECT Username__c, Password__c FROM Jira_Adapter__c];
            if(jiraUsers.size() > 0){
                username = 'shethmihir786@gmail.com';
                password = 'direct@2016';
            }
            
            //JiraBatchInfo__c[] lastBatch = [SELECT of_issues_pulled__c, Batch_Run_Date_Time__c FROM JiraBatchInfo__c ORDER BY Batch_Run_Date_Time__c DESC ];
            //if(lastBatch.size() > 0){
                //lastbatchrun=  string.valueOf(lastBatch [0].Batch_Run_Date_Time__c);
                lastbatchrun = string.valueOf(Datetime.now());
            //}
            
            sameAsJIC();
      }
}