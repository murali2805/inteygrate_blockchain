public class OrComposite extends Composite{
    public override Boolean evaluate(){
        for(Expression expr : children) {
            //System.debug('in OR Composite:'+children);
            System.debug('in OR Evaluate:'+expr);
            if(expr.evaluate())
                return true;
        }
        
        return false;
    }
}