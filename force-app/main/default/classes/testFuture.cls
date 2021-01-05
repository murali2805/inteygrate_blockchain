public class testFuture {
    @future
    public static void futureMethod(){
    	System.debug('\n **** 1st Future Called:'+Limits.getFutureCalls());
        
    }
    
    @future
    public static void secondFuture(){
        System.debug('\n **** 2nd Future Called:'+Limits.getFutureCalls());
    }
	
}