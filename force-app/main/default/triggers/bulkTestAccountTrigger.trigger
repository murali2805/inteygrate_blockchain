trigger bulkTestAccountTrigger on Account (before update) {
    
    System.debug('------------- Size:'+ System.isFuture());
    for(integer i=0;i<40;i++)
        testFuture.futureMethod();
    List<Contact> conList = [SELECT id FROM Contact LIMIT 1];
    update conList[0];
    System.debug('\n **** bulkTestAccountTrigger:'+Limits.getFutureCalls());
}