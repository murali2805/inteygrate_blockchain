@isTest
public class AddPrimaryContactTest {
	@isTest static void testMethod1(){
        List<Account> accList = new List<Account>();
        for(integer i=0;i<50;i++){
            Account a = new Account(Name='name'+i,BillingState='NY');
            accList.add(a);
            Account a2 = new Account(Name='new name'+i,BillingState='CA');
            accList.add(a2);
        }

        insert accList;
        Contact c = new Contact(LastName='new contact');
        insert c;
        Test.startTest();
        AddPrimaryContact apc = new AddPrimaryContact(c,'CA');
        System.enqueueJob(apc);
        Test.stopTest();
        System.assertEquals(50, [select count() from Contact where Account.BillingState = 'CA']);
    }
}