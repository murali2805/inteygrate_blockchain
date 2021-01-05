@isTest
private class ParkLocatorTest {
	 @isTest static void testCallout() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        // Call the method that invokes a callout
        
        // Verify that a fake result is returned
        String[] actualResponse = ParkLocator.country('Japan');
        String[] expectedResponse = new String[]{'Shiretoko National Park', 'Oze National Park', 'Hakusan National Park'};
        System.assertEquals(expectedResponse, actualResponse); 
    }
}