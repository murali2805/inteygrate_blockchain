public abstract class Marker {
    public static Integer PRIVATE_INT_CONST2;
	static{
         PRIVATE_INT_CONST2 =calculate();
    }
    
    public static Integer calculate() {
       return 2 + 7;
    }
    public Marker(){
        write();
        sObject p;
        
    }
    public virtual void write() {
        System.debug('cnst:'+PRIVATE_INT_CONST2);
       
    }

    public Double discount() {
        return .05;
    }
    
    abstract void absmeth();
}