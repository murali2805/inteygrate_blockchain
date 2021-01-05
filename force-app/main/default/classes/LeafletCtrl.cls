public class LeafletCtrl {

    @AuraEnabled
    public static String RepLocation(String currentLoc)
    {
        Double apmntLat = Double.ValueOf(currentLoc.split(',')[0]);
        Double apmntLon = Double.valueOf(currentLoc.split(',')[1]);
        Integer radius = 5;
        String repLocations='';
        System.debug('crrentLoc '+currentLoc);
        String strQry = 'select latitude,longitude from User'; // where distance(latitude__c,GEOLOCATION('+apmntLat+','+apmntLon+'),\'km\') <'+Integer.valueOf(radius);
        List<User> uList = Database.query(strQry);
        for(User u: uList)
        {
            if(u.latitude!=null && u.longitude!=null)
            {
            repLocations+=u.latitude +','+u.longitude+'##';
            }
        }
        if(!string.isBlank(repLocations) && repLocations.length() > 0)
        {
            System.debug('***** Values: '+repLocations.substring(0,repLocations.length()-2));
          return repLocations.substring(0,repLocations.length()-2);  
        }
        else
          return null;
    }
}