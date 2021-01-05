public class EcommerceItems {
    
    
    public List<items__c> itemsList{get;set;}
    public List<Contact> conList{get;set;}
    
    public EcommerceItems(){
        
        itemsList = new List<items__c>();
        
        itemsList = [SELECT id, Name FROM items__c];
        conList = [SELECT id, Name FROM Contact];
    }

}