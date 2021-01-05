trigger ClosedOpportunityTrigger on Opportunity (before insert, before update, before
    delete, after insert, after update, after delete,  after undelete) {
        
	if (Trigger.isAfter && (Trigger.isInsert || Trigger.isUpdate)) {
        List<Task> tasks = new List<Task>();
        
        set<id> TaskWhatIDs = new set<id>();
        for(Task t: [select WhatId from Task where what.type = 'Opportunity' AND WhatId IN:Trigger.new]){
            TaskWhatIDs.add(t.whatId);
        }

		Opportunity[] opps = [SELECT id,Name,StageName  from opportunity where id IN:Trigger.new and id NOT in :TaskWhatIDs];
        for(Opportunity opp:opps){
            if(opp.StageName=='Closed Won'){
                Task t = new Task();
                t.Subject ='Follow Up Test Task';
                t.WhatId = opp.id;
                tasks.add(t);
            }
        }
        if(tasks.size()>0)
            insert tasks;
    }
}