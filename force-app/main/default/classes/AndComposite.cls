public class AndComposite extends Composite{
    public override Boolean evaluate(){
        for(Expression expr : children){
            //System.debug('in And Composite:'+children);
            System.debug('in And Evaluate:'+expr);
            if(!expr.evaluate()) 
            	return false;
        }
        return true;
    }
}