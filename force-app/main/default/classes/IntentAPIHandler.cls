/*
    This class is used to make callout to the Intent API. 
*/

public class IntentAPIHandler {
    
    public static String getAccessToken() {
        // Ignore the File upload part and "jwt.pkcs" if you used a Salesforce certificate to sign up 
        // for an Einstein Platform account
        List<ContentVersion> base64ContentList = [SELECT Title, VersionData FROM ContentVersion where Title='einstein_platform' OR  Title='predictive_services' ORDER BY Title LIMIT 1];
        ContentVersion base64Content = base64ContentList[0];
        String keyContents = base64Content.VersionData.tostring();
        keyContents = keyContents.replace('-----BEGIN RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('-----END RSA PRIVATE KEY-----', '');
        keyContents = keyContents.replace('\n', '');

        // Get a new token
        JWT jwt = new JWT('RS256');
        // jwt.cert = 'JWTCert'; // Uncomment this if you used a Salesforce certificate to sign up for an Einstein Platform account
        jwt.pkcs8 = keyContents; // Comment this if you are using jwt.cert
        jwt.iss = 'developer.force.com';
        jwt.sub = 'murali.sampathirao@inteygrate.com';
        jwt.aud = 'https://api.metamind.io/v1/oauth2/token';
        jwt.exp = '3600';
        String access_token = JWTBearerFlow.getAccessToken('https://api.metamind.io/v1/oauth2/token', jwt);
        return access_token;    
    }
    
    /*public static List<Vision.Prediction> callIntent(String description) {
        // Get a new token
        String access_token = getAccessToken();
    
        // Make a prediction using URL to a file
        return Vision.predictUrl(description,access_token,'BIS2UXVGPBSQMCI6BHSGK6INZE');
    }*/
    
    public static String callIntent(String description) {
        // Get a new token
        String access_token = getAccessToken();
        System.debug('\n\n--------------access_token----------\n\n'+ access_token);
        // Make a prediction using URL to a file
        List<Vision.Prediction> intentList = Vision.predictUrl(description,access_token,'BIS2UXVGPBSQMCI6BHSGK6INZE');
        if(intentList != null && intentList.size() > 0){
            return intentList[0].label;
        }
        
        return null;
    }
    
    


}