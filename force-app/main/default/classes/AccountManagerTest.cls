@isTest
private class AccountManagerTest {
    @isTest static void testMethod1(){
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://inteygrate-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAcc = AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
        System.assertEquals('Test record', thisAcc.Name);
    }
    
    // Helper method
    static Id createTestRecord() {
        // Create test record
        Account acc = new Account(
            Name='Test record'
        );
        
        insert acc;
        Contact c = new Contact(LastName='TestContact',AccountId=acc.Id);
        insert c;
        return acc.Id;
    }       
}