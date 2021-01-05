public class ExtController{

    public List<Account> accList{get;set;}
    public Account acc{get;set;}
    public String suffix{get;set;}
    
    public ExtController(){
        accList = new List<Account>();
        accList = [SELECT id, Name FROM Account LIMIT 5];
        acc=accList[0];
    }
    
    public void customSave(){
        acc.Name = acc.Name + suffix;
        update acc;
        apexpages.addMessage(new ApexPages.message(Apexpages.Severity.INFO,suffix+' added and saved'));
    }
}