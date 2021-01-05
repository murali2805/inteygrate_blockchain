public class myControllerExtension {

    public static void m2(Map<id,Account> mymap){
        mymap = new Map<Id,Account>([select id from account limit 5]);
    }
    
    public static void m1(){
        Map<Id,Account> mymap = new Map<Id,Account>();
        m2(mymap);
        System.debug(mymap.size());
    }
    public static void meth(String e1){
        System.debug(e1);
    }
    
    public static void meth(Integer e2){
        System.debug(e2);
    }
    
    private final Account acct;
    
    // The extension constructor initializes the private member
    // variable acct by using the getRecord method from the standard
    // controller.
    public myControllerExtension(ApexPages.StandardController stdController) {
        this.acct = (Account)stdController.getRecord();
    }
    
    public ApexPages.StandardSetController setcon{
        get{
            if(setcon==null){
                setcon = new ApexPages.StandardSetController(Database.getQueryLocator([SELECT id,Name FROM Account]));
            }
            return setcon;
        }
        set;
    }
    
    public List<Account> getAcs(){
        return (List<Account>) setCon.getRecords();
    }

    public String getGreeting() {
        return 'Hello ' + acct.name + ' (' + acct.id + ')';
    }
}