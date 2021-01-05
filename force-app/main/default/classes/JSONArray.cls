public class JSONArray {

    public class JsonClass {
        public Integer a;
        public String b;
    }
    
    public JSONArray(){
        String jsonc = '{"Key":[{"a":"2","b":"Kabira"},{"a":"34","b":"value"}]}';
        JSONParser parser =JSON.createParser(jsonc);
        
        System.debug(parser.nextToken());
        System.debug(parser.nextToken());
        System.debug(parser.nextToken());
        List<JsonClass> jslist = (List<JsonClass>) parser.readValueAs(List<JsonClass>.class);
        System.debug('*******jslist'+jslist);
        for(JsonClass j:jsList){
            System.debug('*******a:'+j.a);
            System.debug('*******b:'+j.b);
        }
    }
    
}