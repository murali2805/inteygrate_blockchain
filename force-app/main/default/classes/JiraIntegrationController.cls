public class JiraIntegrationController {

      public List<JiraIssue__c> supportIssues {get;set;}
      public String issueKey{get;set;}
      string searchKey = '';
      public string username = 'shethmihir786@gmail.com';
      public string password = 'direct@2016';
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
            

    /******************************* Issue Class ***********************************************/
    
    public class issue{
          public string expand;
          public fields fields;
          public string id;
          public string key;
          public string self;
          
      }

    
        public class Status {
        public String self;
        public String description;
        public String iconUrl;
        public String name;
        public String id;
        public StatusCategory statusCategory;
    }

    public class Assignee {
        public String self;
        public String name;
        public String key;
        public String emailAddress;
        public AvatarUrls avatarUrls;
        public String displayName;
        public Boolean active;
        public String timeZone;
    }

    public class Comment {
        public Integer startAt;
        public Integer maxResults;
        public Integer total;
        public List<Comments> comments;
    }

    public String expand;
    public String id;
    public String self;
    public String key;
    public Fields fields;

    public class links {
        public String self;
    }

    public class Priority {
        public String self;
        public String iconUrl;
        public String name;
        public String id;
    }

    public class Comments {
        public String self;
        public String id;
        public Assignee author;
        public String body;
        public Assignee updateAuthor;
        public String created;
        public String updated;
    }

    public class Aggregateprogress {
        public Integer progress;
        public Integer total;
    }

    public class Watches {
        public String self;
        public Integer watchCount;
        public Boolean isWatching;
    }

    public class StartTime {
        public String iso8601;
        public String friendly;
        public Long epochMillis;
    }

    public class Customfield_10025 {
        public Integer id;
        public String name;
        public links links;
        public List<FixVersions> completedCycles;
        public OngoingCycle ongoingCycle;
    }

    public class Customfield_10026 {
        public String errorMessage;
    }

    public class Customfield_10015 {
        public String errorMessage;
        public I18nErrorMessage i18nErrorMessage;
    }

    public class OngoingCycle {
        public StartTime startTime;
        public StartTime breachTime;
        public Boolean breached;
        public Boolean paused;
        public Boolean withinCalendarHours;
        public GoalDuration goalDuration;
        public GoalDuration elapsedTime;
        public GoalDuration remainingTime;
    }

    public class Project {
        public String self;
        public String id;
        public String key;
        public String name;
        public AvatarUrls avatarUrls;
    }

    public class StatusCategory {
        public String self;
        public Integer id;
        public String key;
        public String colorName;
        public String name;
    }

    public class Worklog {
        public Integer startAt;
        public Integer maxResults;
        public Integer total;
        public List<FixVersions> worklogs;
    }

    public class Fields {
        public String summary;
        public Project project;
       /* public Issuetype issuetype;
        public String timespent;
        public Project project;
        public List<FixVersions> fixVersions;
        public String aggregatetimespent;
        public String resolution;
        public String resolutiondate;
        public Integer workratio;
        public String lastViewed;
        public Watches watches;
        public String created;
        public String customfield_10020;
        public String customfield_10021;
        public Priority priority;
        public Customfield_10025 customfield_10025;
        public List<FixVersions> labels;
        public Customfield_10026 customfield_10026;
        public List<FixVersions> customfield_10016;
        public String customfield_10017;
        public String customfield_10018;
        public String customfield_10019;
        public String timeestimate;
        public String aggregatetimeoriginalestimate;
        public List<FixVersions> versions;
        public List<FixVersions> issuelinks;
        public Assignee assignee;
        public String updated;
        public Status status;
        public List<FixVersions> components;
        public String timeoriginalestimate;
        public String description;
        public String customfield_10010;
        public String customfield_10011;
        public String customfield_10012;
        public String customfield_10013;
        public String customfield_10014;
        public FixVersions timetracking;
        public Customfield_10015 customfield_10015;
        public String customfield_10005;
        public String customfield_10006;
        public String customfield_10007;
        public String customfield_10008;
        public List<FixVersions> attachment;
        public String customfield_10009;
        public String aggregatetimeestimate;
        public String summary;
        public Assignee creator;
        public List<FixVersions> subtasks;
        public Assignee reporter;
        public String customfield_10000;
        public Aggregateprogress aggregateprogress;
        public String customfield_10001;
        public String customfield_10002;
        public String customfield_10003;
        public String customfield_10004;
        public String environment;
        public String duedate;
        public Aggregateprogress progress;
        public Comment comment;
        public Votes votes;
        public Worklog worklog; */
    }

    public class FixVersions {
    }

    public class I18nErrorMessage {
        public String i18nKey;
        public List<FixVersions> parameters;
    }

    public class Issuetype {
        public String self;
        public String id;
        public String description;
        public String iconUrl;
        public String name;
        public Boolean subtask;
    }

    public class AvatarUrls {
        public String fortyEight;
        public String twentyFour;
        public String sixteen;
        public String thirtyTwo;
    }

    public class GoalDuration {
        public Integer millis;
        public String friendly;
    }

    public class Votes {
        public String self;
        public Integer votes;
        public Boolean hasVoted;
    }
    
    /*******************************************************************************************/
      
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
     
      public void sameAsJIC(){

            Http http = new Http();
            HttpRequest req = new HttpRequest();
            
            //string datecleansing = lastbatchrun.replace(' ','%20');
            //string filter = 'updatedDate>'+'%27'+datecleansing.substring(0, datecleansing.length() - 3)+'%27';
            //string filter = 'status=closed%20and%20category%20=%27akritiv%20support%27';
            if(searchKey!='')
                //filter = 'key='+searchKey;
            string fields =     'key,'+
                                'assignee,'+
                                'project,'+
                                'summary,'+
                                'created,'+
                                'updated,'+
                                'issuetype,'+
                                'priority,'+
                                'customfield_11600,'+
                                'resolution,'+
                                'resolutiondate,'+
                                'customfield_11100,'+
                                'status';
                                
            System.debug('+++++++++++++++++++++++++++++++++++++Final URL:'+'https://mihirs.atlassian.net/rest/api/2/search?jql=' +
                            '&os_username=' + username + 
                            '&os_password=' + password +
                            '&fields=' + fields + 
                            '&startAt='+ startAt +
                            '&maxResults='+maxResults);
                            
            HttpResponse res;
            String JSONContent = '{'+
                                  '\"offset\" : 0,'+
                                  '\"rows\": ['+
                                    '{ \"databases\" : [ '+
                                     '{ \"name\" : \"hiccupcard\", '+
                                       '\"sizeOnDisk\" : 83886080, '+
                                       '\"empty\" : false'+
                                     '}, '+
                                     '{ \"name\" : \"local\", '+
                                       '\"sizeOnDisk\" : 83886080, '+
                                       '\"empty\" : false '+
                                     '} ], '+
                                  '\"totalSize\" : 167772160, \"ok\" : 1 }'+
                                  '],'+
                                  '\"total_rows\" : 1 ,'+
                                  '\"query\" : { \"listDatabases\" : 1 } ,'+
                                  '\"millis\" : 1'+
                                '}';
            
            if(!Test.isRunningTest()){
                req.setEndpoint('https://mihirs.atlassian.net/rest/api/2/search?jql='+
                                '&os_username=' + username + 
                                '&os_password=' + password +
                                //'&fields=' + fields + 
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
            
            
                res = http.send(req);
            
        
                // Log the JSON content
                System.debug('JSON Response: ' + res.getBody());
                
                JSONContent = res.getBody();
            }
            supportIssues = new List<JiraIssue__c>();
            //------------------------------------------------------------------------------------------
            JSONParser parserJira = JSON.createParser(JSONContent);
            Integer cnt = 0;
            while (parserJira.nextToken() != null) 
            {
                
                // Start at the array of issues.
                if (parserJira.getCurrentToken() == JSONToken.START_ARRAY) {
                    while (parserJira.nextToken() != null) {
                    System.debug('[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[['+parserJira.getCurrentToken() );
                        if ((parserJira .getCurrentToken() == JSONToken.START_OBJECT)){ 
                            if(cnt>2)break;
                            issue jiraIssue = (issue)parserJira.readValueAs(issue.class);
                            cnt++;
                            System.debug('Key ' + jiraIssue.key);
                            System.debug('Project:' + jiraIssue.fields.project.key);
                            JiraIssue__c supportIssue = new JiraIssue__c();
                            supportIssue.Issue_Key__c = jiraIssue.key;
                            //Account[] acts = [SELECT id,Name, Site FROM Account WHERE Name= :jiraIssue.fields.project.key];
                            //if(acts.size()> 0){
                                //supportIssue.Account_Name__c = acts[0].id ;
                            //}
                            System.debug('#############jiraIssue.key#################'+jiraIssue.key);
                            JiraIssue__c[] existingIssues = [SELECT id,
                                                                         Issue_Key__c,
                                                                         Summary__c
                                                                         FROM JiraIssue__c WHERE Issue_Key__c = :jiraIssue.key];
                                                          
                            supportIssue.Summary__c = jiraIssue.fields.summary;
                            
                            //supportIssue.Created_Date__c = jiraIssue.fields.created;
                            //supportIssue.Updated_Date__c = jiraIssue.fields.updated;
                            
                            //supportIssue.Issue_Type__c = jiraIssue.fields.issuetype.name;
                            //supportIssue.Priority__c = jiraIssue.fields.priority.name;
                            //supportIssue.Assignee__c = jiraIssue.fields.assignee.displayName;                            
                            /*
                            if(jiraIssue.fields.customfield_11600!=null)
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
                            /*
                            else if(compare(existingIssues[0],supportIssue))
                                supportIssue.syncStatus__c = 2 ;
                            else
                                supportIssue.syncStatus__c = 1 ;
                            */

//                            if(supportIssue.syncStatus__c == 0)
                            supportIssues.add(supportIssue);
                           
                            
                        }
                       
                    }
                    System.debug('##############################');
                }
            }
            

            //------------------------------------------------------------------------------------------          
      }
      
      public boolean compare(JiraIssue__c thisIssue,JiraIssue__c supportIssue){
          boolean flag = false;
          
          System.debug('//////////////////////////////////////////////////////////////////////');
          if(thisIssue.Summary__c == supportIssue.Summary__c) System.debug('Summary__c True');
          /*if(thisIssue.Updated_Date__c == supportIssue.Updated_Date__c) System.debug('Updated_Date__c True');
          if(thisIssue.Issue_Type__c == supportIssue.Issue_Type__c) System.debug('Issue_Type__c True');
          if(thisIssue.Priority__c == supportIssue.Priority__c) System.debug('Priority__c True');
          if(thisIssue.Assignee__c == supportIssue.Assignee__c) System.debug('Assignee__c True');
          if(thisIssue.Product__c == supportIssue.Product__c) System.debug('Product__c True');
          if(thisIssue.Resolution__c == supportIssue.Resolution__c) System.debug('Resolution__c True');
          if(thisIssue.Resolved_Date__c == supportIssue.Resolved_Date__c) System.debug('Resolved_Date__c True');
          if(thisIssue.Root_Cause__c == supportIssue.Root_Cause__c) System.debug('Root_Cause__c True');
          if(thisIssue.Status__c == supportIssue.Status__c) System.debug('Status__c True');
          */
          //System.debug('END //////////////////////////////////////////////////////////////////////');
          
          try{
              if(    (thisIssue.Summary__c.trim() == supportIssue.Summary__c.trim()) /*&&
                     (thisIssue.Updated_Date__c == supportIssue.Updated_Date__c) &&
                     (thisIssue.Issue_Type__c == supportIssue.Issue_Type__c) &&
                     (thisIssue.Priority__c == supportIssue.Priority__c) &&
                     (thisIssue.Assignee__c == supportIssue.Assignee__c) &&
                     (thisIssue.Product__c  == supportIssue.Product__c) &&
                     (thisIssue.Resolution__c  == supportIssue.Resolution__c)  &&
                     (thisIssue.Resolved_Date__c == supportIssue.Resolved_Date__c) &&
                     (thisIssue.Root_Cause__c == supportIssue.Root_Cause__c) &&
                     (thisIssue.Status__c == supportIssue.Status__c)*/
                 ){
                     flag = true;
               }
           }catch(Exception e){
               System.debug('!!!!!!!!!!Exception while comparison!!!!!!!!!!!!!!!');
           }
           //System.debug(deleteWhitespace(supportIssue.Assignee__c));
           System.debug('Difference-------------'+thisIssue.Summary__c.difference(supportIssue.Summary__c)+'::::'+thisIssue.Summary__c.replace(' ','#')+' vs. '+ supportIssue.Summary__c.replace(' ','#'));
           return flag;
      }
    
    
      public JiraIntegrationController() {
      
            System.debug('\n\nGot into controller');
            Jira_Adapter__c[] jiraUsers = [SELECT Username__c, Password__c FROM Jira_Adapter__c];
            if(jiraUsers.size() > 0){
                 username = 'shethmihir786@gmail.com';
       			 password = 'direct@2016';
            }
            
            /*
            JiraBatchInfo__c[] lastBatch = [SELECT of_issues_pulled__c, Batch_Run_Date_Time__c FROM JiraBatchInfo__c ORDER BY Batch_Run_Date_Time__c DESC ];
            if(lastBatch.size() > 0){
                lastbatchrun=  string.valueOf(lastBatch [0].Batch_Run_Date_Time__c);
            }
            */
            
            sameAsJIC();
      }
}//