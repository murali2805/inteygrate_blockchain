public class AccountProcessor {
    @future
    public static void countContacts(List<id> acctIds){
        List<Account> acctList = new List<Account>();
        acctList = [select id,Number_of_Contacts__c, (Select id from Contacts) from Account];
        for(Account a:acctList){
            a.Number_of_Contacts__c = a.Contacts.size();
        }
        update acctList;
        
    }

}