trigger ContactTrigger on Contact (before update) {
	testFuture.secondFuture();
    testFuture.futureMethod();
    System.debug('\n **** ContactTrigger:'+Limits.getFutureCalls());
}