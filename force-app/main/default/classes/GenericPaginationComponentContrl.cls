/* Description:
   * ============
   * Class for the VF Component GenericPaginationComponent * 
   * Author:
   * ========
   * www.srinusfdc.com  
   */
 public class GenericPaginationComponentContrl {
   
  //Stores the records which are supplied to the 'Records' attribute.
  public Sobject[] sObjLst {get;set;}
  public integer isrefreshed {get;set;}
  public integer lastrefresh=0;
  
 
  public void setsObjLst(Sobject[] newlist){
      System.debug('\n\n--------------------\n\n setter called \n\n----------------------\n\n'); 
  }
  
  public integer size = 0;
   
  /*
   1. Implementing the pagination with ApexPages.StandardSetController.
   2. We can utilize the built in methods available for the ApexPages.StandardSetController to build the pagination.
   3. Following are the built in mehods we can utilize -
    a. first()
    b. previous()
    c. next()
    d. last()
    e. getHasPrevious() - returns boolean value.
    f. getHasNext() - returns boolean value.
    g. setPageSize(IntegerValue)
  */
  public ApexPages.StandardSetController con {
   get {
    //initializing con with the records.
    System.debug('\n\n--------------------\n\n refreshed in getter:'+isrefreshed+'\ncon:'+con+'\n\n----------------------\n\n'); 
    if(con == null){
     con = new ApexPages.StandardSetController(sObjLst);
     //size = sObjLst.size();
    }
     
    //Setting the pagination size
    con.setPageSize(5);
     
    return con;
   }
   set;
  }
  
  
   
  //Method which returns subset of records from the sObjLst.
  public List<sobject> getSobjRecords() {        
   //Type Casing the records and returning to display on the page.
   System.debug('\n\n--------------------\n\n refreshed:'+isrefreshed+'\n\nsObjList:'+sObjLst.size()+'\n\n----------------------\n\n'); 
   if(isrefreshed == lastrefresh){
       System.debug('\n\n--------------------\n\n Indside refresh condition\n\n----------------------\n\n'); 
       con = new ApexPages.StandardSetController(sObjLst);
       //con.setPageSize(5);
       //size=sObjLst.size();
       // isrefreshed = false;
       lastrefresh = lastrefresh+1;
   }
   
   return (List<sobject>)con.getRecords();
  }
 }