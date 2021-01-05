@isTest
public class LeadProcessorTest {
    @isTest static void testMethod1(){
        List<Lead> leadList = new List<Lead>();
        for(integer i=0;i<201;i++){
            Lead l = new Lead(LastName='name'+i,Company='company'+i);
            leadList.add(l);
        }
        insert leadList;
        
        Test.startTest();
        Database.executeBatch(new LeadProcessor(),300);
        Test.stopTest();
        System.assertEquals(201, [select count() from Lead where LeadSource = 'Dreamforce']);
    }

}