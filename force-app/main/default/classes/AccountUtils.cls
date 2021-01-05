public class AccountUtils {
    
    public static List<Account> accountsByState(String state){
        List<Account> accounts = [SELECT id, Name FROM Account WHERE BillingState=:state];
        return accounts;
    }

}