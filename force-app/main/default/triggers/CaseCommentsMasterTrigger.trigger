trigger CaseCommentsMasterTrigger on CaseComment (before insert,after insert, after Update, before Delete) {
    CaseCommentHandler CommentHandler = new CaseCommentHandler();
    if(trigger.isInsert){
        if(trigger.isAfter){
           CommentHandler.afterInsert(trigger.new);
        }
        
    }
    else{
      if(trigger.isUpdate){
           CommentHandler.afterUpdate(trigger.newMap, trigger.oldMap); 
      }
      else{
        if(trigger.isDelete){
            CommentHandler.beforeDelete(trigger.old); 
          }
       }
    }
}