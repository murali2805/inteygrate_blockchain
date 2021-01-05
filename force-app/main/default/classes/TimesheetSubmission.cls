public with sharing class TimesheetSubmission{

    public List<Timesheet__c> workLogs {get;set;}
    public Map<String,Timesheet__c> workLogsMap {get;set;}
    public Timesheet__c editWorklog{get;set;}
    public String thisId{get;set;}
    public String mode{get;set;}
    
    public TimesheetSubmission(){
        editWorklog = new Timesheet__c();
        workLogs = new List<Timesheet__c>();
        workLogs = [SELECT Id, Name, Jira__c, Hours__c, Comments__c, Date__c, Resource__c FROM Timesheet__c];
        
        workLogsMap = new Map<String,Timesheet__c>();
        for(Timesheet__c t : workLogs){
            workLogsMap.put(t.id,t);
        }
        
        
    }
    
    public void getThisRecordDetails(){
        if(mode == 'edit')
            editWorkLog = workLogsMap.get(thisId);
        else
            editWorkLog = new Timesheet__c();
    }
    
    
    public void updateWorklog(){
        System.debug('\n\n-------- '+editWorklog);
        System.debug('\n\n--------thisId '+ thisId);
        if(mode == 'edit'){
            update editWorkLog;
            workLogsMap.put(thisId,editWorkLog);
        }
        else{
            insert editWorkLog;
            workLogs.add(editWorkLog);
        }
    }
}