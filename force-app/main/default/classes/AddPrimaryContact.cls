public class AddPrimaryContact implements Queueable{
    private Contact c;
    private String state;
    
    public AddPrimaryContact(Contact c,String state){
        this.c=c;
        this.state=state;
    }
    
    public void execute(QueueableContext context){
        List<Account> accounts = new List<Account>();
        accounts = [select id from account where BillingState =:state limit 200];
        List<Contact> contactList = new List<Contact>();
        for(Account a:accounts){
            Contact newCon = c.clone(false,false,false,false);
            newCon.AccountId = a.Id;
            contactList.add(newCon);
        }
        insert contactList;
    }
}