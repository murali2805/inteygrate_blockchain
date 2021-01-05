trigger CreateJiraIssue on JiraIssue__c (before insert) 
{
    if(Trigger.isBefore)
    {
        if(Trigger.IsInsert)
        {
           for(JiraIssue__c cc:trigger.new)
            { 
                string issuekey = cc.Issue_Key__c;
                System.debug('cc.Issue_Key__c=='+cc.Issue_Key__c);
            }
        }
                 
     }
}