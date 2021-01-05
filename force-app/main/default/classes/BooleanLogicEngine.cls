public class BooleanLogicEngine
{
    Public BooleanLogicEngine()
    {
        result = '';
        logicString = '';
        
        //System.debug(parseSeparators('OR[OR[TRUE, AND[TRUE, FALSE]], AND[TRUE, FALSE]] '));
    }
    
    Public String logicString{get;set;}
    Public String result{get;set;}
    
    Public pageReference computeLogic()
    {
        System.debug('***logic'+logicString);
        logicString = logicString.deleteWhitespace().replace('"', '').replace('{', '').replace('}', '').replace(':', '');
        String[] params = parseSeparators(logicString).split(';');
        result = (''+processLogic(params[0], params[1], params[2])).toUpperCase();
        
        System.debug('***Result'+result);
        
        return null;
    }
    
    Private Boolean processLogic(String Op, String p1, String p2)
    {
        Boolean b1,b2;
        if( p1 == 'true' || p1 == 'false')
        {
            b1 = Boolean.valueOf(p1);
        }
        else
        {
            String[] params = parseSeparators(p1).split(';');
            b1 = processLogic(params[0], params[1], params[2]);
        }
        
        if(p2 == 'false' || p2 == 'true')
        {
            b2 = Boolean.valueOf(p2);
        }
        else
        {
            String[] params = parseSeparators(p2).split(';');
            b2 = processLogic(params[0], params[1], params[2]);
            
        }
        
        if(op == 'OR')
        {
            return (b1 || b2);
        }
        if(op == 'AND')
        {
            return (b1 && b2);
        }
        return false;
    }
    
    Private String parseSeparators(String parseQuery)
    {
        Integer bcount=0,o=0;
        String arg;
        System.debug(parseQuery);
        if(parseQuery == 'TRUE' || parseQuery == 'FALSE')
            return parseQuery;
        
        String s1 = '';
        String s2 = '';
        String op = '';
        
        op = parseQuery.substringBefore('[');
        arg = parseQuery.substringAfter('[').substringBeforeLast(']');
        for(integer i=0;i<arg.length();i++)
        {
            if(arg.substring(i, i+1) == '[')
            {
                bcount++;
            }
            if(arg.substring(i, i+1) == ']')
            {
                bcount--;
            }
            if(arg.substring(i, i+1) == ',' & bcount==0)
            {
                s1 += ';'+arg.substring(o,i);
            	o = i+1;
            }
        }
        s1 += ';'+arg.substring(o);
        return op+''+s1+';'+s2;
    }
}