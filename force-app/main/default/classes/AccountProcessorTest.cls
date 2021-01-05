@isTest
public class AccountProcessorTest {
	@isTest
    static void testMethod1(){
        Account acc = new Account(Name='acc1');
        insert acc;
        List<Contact> cList = new List<Contact>();
        for(integer i=0;i<5;i++){
            Contact c = new Contact(LastName='last'+i,FirstName='first'+i,AccountId=acc.id);
            cList.add(c);
        }
        insert cList;
        
        Test.startTest();
        List<Id> accIds = new List<Id>{acc.Id};
        AccountProcessor.countContacts(accIds);
        Test.stopTest();
    }
}