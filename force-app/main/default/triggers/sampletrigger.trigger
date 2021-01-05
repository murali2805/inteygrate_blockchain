trigger sampletrigger on Account (before insert) {
    
    class AccountClass{
        Integer x;
        Integer y=99;
        AccountClass(){x=11;y=10;}
    }
    
    If(Trigger.isBefore && Trigger.isInsert){
        System.debug(new AccountClass().x);
    }

}