public class CalloutHandler{
    
    @future(callout=true)
    public static void UnzipCallout(){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('http://inteygrate-developer-edition.ap6.force.com/muralidhar/unzipdemo');
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        System.debug('\n\n--------'+response.getBody());
        
        //PageReference page = new PageReference('https://inteygrate-dev-ed.my.salesforce.com/apex/unzipdemo');
        
    }
}