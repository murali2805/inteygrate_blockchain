public class InteygrateVisitLogger{

    public InteygrateVisitLogger(){
      
    }
    
    public PageReference logAndRedirect(){
      String referer = ApexPages.currentPage().getHeaders().get('referer');
      PageReference retURL = new PageReference('https://login.uber.com/oauth/v2/authorize?response_type=code&client_id=1KZQ_3P83UrP2VXxxEHnEGL9dd0F2O_z&scope=profile');
      retURL.setRedirect(true);
      return retURL;
    }
}