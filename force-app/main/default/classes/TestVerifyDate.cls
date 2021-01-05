@isTest
private class TestVerifyDate {
    @isTest static void testDateRangePositive(){
        Date d1 = Date.newInstance(2019,7,1);
        Date d2 = Date.newInstance(2019,7,20);
        Date expectedDate = d2;
        Date actualDate = VerifyDate.CheckDates(d1,d2);
        System.assertEquals(expectedDate,actualDate);
    }
    
    @isTest static void testDateRangeNegative(){
        Date d1 = Date.newInstance(2019,7,1);
        Date d2 = Date.newInstance(2019,8,1);
        Date expectedDate = Date.newInstance(2019,7,31);
        Date actualDate = VerifyDate.CheckDates(d1,d2);
        System.assertEquals(expectedDate,actualDate);
    }
}