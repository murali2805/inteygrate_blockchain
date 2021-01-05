trigger AccountAddressTrigger  on Account (before insert, before update, before
    delete, after insert, after update, after delete,  after undelete) {

    if (Trigger.isBefore && Trigger.isInsert) {
        AccountTriggerHandler.CreateAccounts(Trigger.New);
    }
        
    if (Trigger.isBefore) {
        if(Trigger.isInsert || Trigger.isUpdate)
        	AccountTriggerHandler.matchBillingState(Trigger.New);
    }
        
    if (Trigger.isUpdate) {
        System.debug('After:'+Trigger.isAfter);
        Account a = Trigger.New[0];
        Account a2 = [Select Formula_State__c from Account where id=:a.id];
        System.debug('Trigger.New:'+a.Formula_State__c);
        System.debug('Queried Record:'+a2.Formula_State__c);
        System.debug('Trigger Size:'+Trigger.Size); 
        a2.recalculateFormulas();
        System.debug('After Recalculation:'+a2.Formula_State__c);
        
    }
}