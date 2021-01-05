public class AccountTriggerHandler {

    public static void CreateAccounts(List<Account> accts) {
        for (Account a : accts) {
            a.ShippingState = a.BillingState;
        }
        
    }
    
    public static void matchBillingState(List<Account> accts) {
        for (Account a : accts) {
            if(a.Match_Billing_Address__c)
            	a.ShippingPostalCode = a.BillingPostalCode;
            
            /*
            if(a.BillingState=='BA'){
                a.BillingState = 'GA';
            }
			*/
            
            if(a.BillingState=='TA'){
                a.BillingState = 'BA';
                //a.Rating='Hot';
            }
            
            System.debug('=='+a.BillingState);
            if(a.BillingState=='KA'){
                a.BillingState = 'CA';
                
            }
            
        }
        
    }
}