global class oc extends Marker implements myinterface{
    private static Integer gapoochi = 5;
    static integer s;
    
    public override void write(){
        super.write();
        System.debug('ext:'+Marker.PRIVATE_INT_CONST2);
    }
    public class ic{
        //Integer gapoochi=20;
        public ic(){
            //Integer gapoochi =10;
            System.debug(gapoochi);
        }   
    }
    
    public Boolean validate(){
        System.debug('inside interface original method');
        return true;
    }
    
    public Boolean validate(integer a){
        System.debug('inside interface overloaded method');
        return false;
    }
   
    public void absmeth(){
        System.debug('absmeth empty');
    }
    
    public oc(){
        //ic i=new ic();
        //m();
        //write();

    }
    
    private static void m(){
        //System.debug('first:'+s);
        s=5;
        System.debug(s);
        integer s;
        //System.debug('between:'+s);    
        s=10;
        System.debug(s);
        System.debug(oc.s);
    }
}