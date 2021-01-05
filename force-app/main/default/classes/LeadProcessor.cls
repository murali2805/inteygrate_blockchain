global class LeadProcessor implements Database.Batchable<sObject>{
    
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('Select id, LeadSource from Lead');
    }
    
    global void execute(Database.BatchableContext bc, List<Lead> leads){
        for(Lead l:leads){
            l.LeadSource = 'Dreamforce';
        }
        update leads;
    }
    
    global void finish(Database.BatchableContext bc){
        
    }

}