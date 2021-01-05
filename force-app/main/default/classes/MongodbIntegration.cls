public class MongodbIntegration{

    
    public List<Databases> mongodbs{get;set;}

    public class Mongoinfo {
        public Integer offset;
        public List<Rows> rows;
        public Integer total_rows;
        public Query query;
        public Integer millis;
        
    }

    public class Databases {
        public String name{get;}
        public Integer sizeOnDisk{get;}
        public Boolean empty{get;}
    }

    public class Query {
        public Integer listDatabases;
    }

    public class Rows {
        public List<Databases> databases;
        public Integer totalSize;
        public Integer ok;
    }

    public MongodbIntegration(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('http://hiccupcard.com:28017/admin/$cmd/?filter_listDatabases=1&limit=1');
        req.setMethod('GET');
        
        HttpResponse res = http.send(req);
        String JSONContent = res.getBody();
        System.debug('Response:'+JSONContent);
        
        mongodbs = new List<Databases>();
        
        JSONParser parser = JSON.createParser(JSONContent);
        while (parser.nextToken() != null) 
        {
             if (parser.getCurrentToken() == JSONToken.START_OBJECT) {
                 System.debug('++++++++++++++++++'+parser.getCurrentToken() );
                 Mongoinfo info = (Mongoinfo)parser.readValueAs(Mongoinfo.class);
                 mongodbs = info.rows[0].databases;
                 System.debug('Total Rows:' + mongodbs);
             }
        }
    }
    
}