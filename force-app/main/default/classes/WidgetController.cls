@RestResource(urlMapping='/Widgets/*')
global class WidgetController {

    @HttpGet
    global static void getWidgets() {
       //for(integer i=0;i<10000000;i++){
       //}
       
       //return new wrapper('00001248900','8736','test');
       
       RestContext.response.addHeader('Content-Type', 'application/json');
       RestContext.response.addHeader('Access-Control-Allow-Origin', '*');
       String menuid = RestContext.request.params.get('menuid');
       String empid = RestContext.request.params.get('empid');
       String cmpid = RestContext.request.params.get('cmpid');
       //String srid= RestContext.request.params.get('srid');
       
       //Widget__c w = new Widget__c(Name=menuid);
       //insert w;
       
       Case c = new Case(Status='New',Origin = 'Web',Subject=menuid,Description=menuid);
       //--insert c;
       
       List<Widget__c> session = [SELECT empid__c,companyid__c,menuid__c,isValid__c FROM Widget__c WHERE empid__c=:empid and companyid__c =:cmpid order by menuid__c NULLS Last];
      
        if(session!=null && session.size()>0 && cmpid!=null && empid!=null){
            RestContext.response.responseBody = Blob.valueOf('{"data":{ "authorized":'+ session[0].isValid__c +',"employeeId" : "'+session[0].empid__c+'", "companyId" : "'+session[0].companyid__c+'","menuId":"'+menuid +'"}}');
        }
        else{
            RestContext.response.responseBody = Blob.valueOf('{"data":{ "authorized":'+ false +',"employeeId" : "'+''+'", "companyId" : "'+''+'","menuId":"'+menuid +'"}}');
        }

       
       
    }

    @HttpPost 
    global static String createNewWidget(String Name) {
        Widget__c w = new Widget__c();
        w.Name = Name;
        insert w;

        return 'Done';
   }

    @HttpDelete
    global static String deleteWidgetById() {
        String Id = RestContext.request.params.get('Id');
        List<Widget__c> w = [ Select ID from Widget__c where Id= :Id];

        delete w;

        return 'Deleted Widget';
    }

    @HttpPut
    global static String updateWidget(String Id, String NewName) {
        Widget__c w = [ Select ID, Name from Widget__c where Id= :Id];

        w.Name = NewName;
        update w;

        return 'Widget Updated';
    }
    
    
    global class wrapper{
        public string employeeId;
        public string companyId;
        public string menuId;       
        
        public wrapper(string eid,string cid,string mid){
            this.employeeId = eid;
            this.companyId = cid;
            this.menuId = mid;
        } 
    }
}