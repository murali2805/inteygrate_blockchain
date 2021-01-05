@isTest
private class AccountTriggerTest {
    @isTest static void TestCreateNewAccountInBulk() {
        // Test Setup data
        // Create 200 new Accounts
        List<Account> accts = new List<Account>();
        for(Integer i=0; i < 200; i++) {
            Account acct = new Account(Name='Test Account ' + i);
            acct.BillingState = 'CA';
            accts.add(acct);
        }              
        // Perform Test
        Test.startTest();
        insert accts;                               
        Test.stopTest();
        
        // Also verify that 200 new Opportunities were inserted
        List<Account> verifySTAccts = [SELECT Id FROM Account WHERE ShippingState='CA'];                              
        System.assertEquals(200, verifySTAccts.size());                             
    }
}