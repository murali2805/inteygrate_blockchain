trigger CaseTrigger on Case(before insert,after insert, after Update, before Delete) {
    CaseCommentHandler CommentHandler = new CaseCommentHandler();
    if(trigger.isInsert){
        if(trigger.isAfter){
           CaseTriggerHandler.afterInsert(trigger.new);
        }
        
    }
    else{
      if(trigger.isUpdate){
           CaseTriggerHandler.afterUpdate(trigger.newMap, trigger.oldMap); 
      }
    }
}