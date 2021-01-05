public class Excelit{

     public String xlsHeader {
        get {
            String strHeader = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>';
            /*String strHeader = '';
            strHeader += '<?xml version="1.0"?>';
            strHeader += '<?mso-application progid="Excel.Sheet"?>';*/
            return strHeader;
        }
    }
    
    public String f1{
        get{
            String formula = 'LEN(TRIM(A15))=0';
            return formula;
        }
    }
    
    public String f2{
        get{
            String formula = 'IF($A15&lt;&gt;"", C15="", FALSE)';
            return formula;
        }
    }
    
    public String f3{
        get{
            String formula = 'IF(AND(A15&lt;&gt;"",C15&lt;&gt;"",C15&lt;&gt;"No Dependent",D15=""),TRUE,FALSE)';
            return formula;
        }
    }
    public String f4{
        get{
            String formula = 'IF(AND(A15&lt;&gt;"",C15&lt;&gt;"",C15&lt;&gt;"No Dependent",E15=""),TRUE,FALSE)';
            return formula;
        }
    }
    public String f5{
        get{
            String formula = 'IF(AND(A15&lt;&gt;"",C15&lt;&gt;"",C15&lt;&gt;"No Dependent",F15=""),TRUE,FALSE)';
            return formula;
        }
    }
    public String f6{
        get{
            String formula = 'IF(AND(A15&lt;&gt;"",C15&lt;&gt;"",C15&lt;&gt;"No Dependent",G15=""),TRUE,FALSE)';
            return formula;
        }
    }
    public String f7{
        get{
            String formula = 'IF(AND($A15&lt;&gt;"",$C15&lt;&gt;"",$C15&lt;&gt;"No Dependent",H15=""),TRUE,FALSE)';
            return formula;
        }
    }
    public String f8{
        get{
            String formula = 'IF(AND(A15&lt;&gt;"",C15&lt;&gt;"",C15&lt;&gt;"No Dependent",I15=""),TRUE,FALSE)';
            return formula;
        }
    }
}