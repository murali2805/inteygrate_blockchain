({
	myAction : function(component, event, helper) {
		var action = component.get("c.getContacts");
        var isSelectLoaded = false;
        
        action.setCallback(this, function(data) {
        	component.set("v.contacts", data.getReturnValue());
            isSelectLoaded = true;
        });
        $A.enqueueAction(action)
	},

    scriptsLoaded : function(comp,event,helper){
        var selector = "#multiSelectSpan" + comp.get("v.compname");
        console.log(selector);
        console.log('done');
        setInterval(function() {
            console.log('inside set interval')
            if (true) {
                var selector = "#multiSelectSpan" + comp.get("v.compname");
                
                $( selector + " > select").multiselect({
                    onChange: function(option, checked) {
                        console.log(comp.get("v.compname"));
                        console.log($(option).val()+":"+(checked));
                        var s = $(option).val();
                        if(checked)
                            $("#"+comp.get("v.compname")).append(jQuery("<input placeholder='Enter Phone for "+s+"' id='"+s.replace(" ",'-')+"-"+comp.get("v.compname")+"' style='height: 35px;font-size: 14px;width: 25%;margin: 5px;display:block' class='inputonly slds-input' type='text'/>"));   
                        else
                        	$('#'+s.replace(" ",'-')+"-"+comp.get("v.compname")).remove();
                    }
                })
            }
        }, 500);
    },
    
})