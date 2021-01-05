public class CaseTriggerHandler {
   
    public CaseTriggerHandler(){
        
    }
    
    public static void afterInsert(List<Case> newList){
        
        List<Asset_Mapping__mdt> sourceDestMap = new List<Asset_Mapping__mdt>();
        sourceDestMap = [SELECT Source_Field__c,Source_Object__c,Destination_Field__c,Destination_Object__c FROM Asset_Mapping__mdt WHERE Active__c = true];
        
    }
    
    public static void afterUpdate(Map<Id, Case> newMap,Map<Id,Case> OldMap){
       
       List<Id> assetIds = new List<Id>();
       String sourceIdsStr =' (';
       String destIdsStr =' (';
       
       
       
       Map<String,String> caseAssetMap = new Map<String,String>();
       
       for(Case c : newMap.values()){
           assetIds.add(c.AssetId);
           sourceIdsStr = sourceIdsStr + '\''+c.Id+'\',';
           destIdsStr = destIdsStr + '\''+c.AssetId+'\',';
           
           caseAssetMap.put(c.Id,c.AssetId);
       }
       
       
       sourceIdsStr = sourceIdsStr.removeEnd(',') + ')';
       destIdsStr = destIdsStr .removeEnd(',')+ ')';
       
       List<Asset_Mapping__mdt> assetMapping = new List<Asset_Mapping__mdt>();
       assetMapping = [SELECT Source_Field__c,Source_Object__c,Destination_Field__c,Destination_Object__c FROM Asset_Mapping__mdt WHERE Active__c = true];
       
       String sourceRecordsQuery = 'SELECT id';
       String destRecordsQuery = 'SELECT id';
       
       Map<String,String> sourceDestMap = new Map<String,String>();
       
       if(assetMapping.size()>0){
           for(Asset_Mapping__mdt sdMap : assetMapping){
               sourceRecordsQuery = sourceRecordsQuery + ',' + sdMap.Source_Field__c;
               destRecordsQuery = destRecordsQuery + ',' + sdMap.Destination_Field__c;
               sourceDestMap.put(sdMap.Source_Field__c,sdMap.Destination_Field__c);
           }
           sourceRecordsQuery = sourceRecordsQuery + ' FROM ' + assetMapping[0].Source_Object__c + ' WHERE id IN '+sourceIdsStr;
           destRecordsQuery = destRecordsQuery + ' FROM ' + assetMapping[0].Destination_Object__c + ' WHERE Id IN '+destIdsStr;
       }
       System.debug('\n\n----------------- Source Records Query:'+sourceRecordsQuery);
       System.debug('\n\n----------------- Dest Records Query:'+destRecordsQuery);
       System.debug('\n\n----------------- Source To Destination Map:'+sourceDestMap);
       System.debug('\n\n----------------- Case Asset Map:'+caseAssetMap);
       
       List<Case> sourceRecords = new List<Case>();
       List<Asset> destRecords = new List<Asset>();
       
       sourceRecords = Database.query(sourceRecordsQuery);
       destRecords = Database.query(destRecordsQuery);
       
       Map<Id,Asset> assets = new Map<Id,Asset>();
       for(Asset a : destRecords){
           assets.put(a.Id,a);
       }
       
       System.debug('\n\n----------------- Assets:'+assets);
       
       for(Case c : sourceRecords){
           for(String sourceFieldAPI : sourceDestMap.keyset()){
                assets.get(caseAssetMap.get(c.Id)).put(sourceDestMap.get(sourceFieldAPI),c.get(sourceFieldAPI));
                System.debug('\n\n-------------- Asset API:'+sourceDestMap.get(sourceFieldAPI));
                System.debug('\n\n-------------- Asset Record from Map:'+ assets.get(caseAssetMap.get(c.Id)));
                System.debug('\n\n-------------- Final Asset:'+ assets.get(caseAssetMap.get(c.Id)).get(sourceDestMap.get(sourceFieldAPI))); 
                
           }
       }
       
       update destRecords;
       
    }

}