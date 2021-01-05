trigger CreateFeedComment on FeedItem (after insert) {
    List<CaseComment> ccList = new List<CaseComment>();
    for (Integer i = 0; i<trigger.new.size(); i++) {

            String input = trigger.new[i].Body.replace('<br>','%br%');
            input = input.replaceAll('<[/a-zAZ0-9]*>','');
            input = input.replace('%br%','<br>'); //replace back        
            ccList.add(new CaseComment(CommentBody = input, ParentId = trigger.new[i]. ParentId));
            
     
    }
    insert ccList;
}