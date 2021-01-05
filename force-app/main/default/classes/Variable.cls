public class Variable implements Expression{
    public String  name  {get;private set;}
    public Boolean value {get;private set;}
    public Variable(String name){ this.name = name; }
    public Expression add(Expression expr){
        System.debug('Variable add called');
        return this;
    }
    public Expression set(String name, Boolean value){ 
        System.debug(name+' is it equal to '+this.name);
        
        if(this.name != null && this.name.equalsIgnoreCase(name)){
            
            this.value = value;
    	}
        return this; 
    }
    public Boolean evaluate(){
        System.debug('in Variable evaluate:'+value);
        return value; 
    }
}