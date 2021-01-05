@isTest
public class DailyLeadProcessorTest {
	@isTest static void testMethod1(){
        List<Lead> leadList = new List<Lead>();
        for(integer i=0;i<201;i++){
            Lead l = new Lead(LastName='name'+i,Company='company'+i);
            leadList.add(l);
        }
        insert leadList;
        
        Test.startTest();
        String sch ='20 30 8 10 2 ?';
        System.schedule('DailyLeadProcessor',sch,new DailyLeadProcessor());
        Test.stopTest();
        System.assertEquals(201, [select count() from Lead where LeadSource = 'Dreamforce']);
    }
}