/*
    Author: Enrico Murru (http://enree.co)
    
    Repository: https://github.com/enreeco/alexa-force
    
    The MIT License (MIT)

    Copyright (c) 2015 Enrico Murru

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in all
    copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
    SOFTWARE.
*/

//Example of intent implementation using access token from the request
//This skill calls the "GetUserInfo" SOAP method and responds with the user's full name

public class AlexaUserInfoIntent extends AlexaIntent{
    
    public AlexaUserInfoIntent(){
        super('SFUserInfo');
        List<String> utterances = new List<String>();
        utterances.add('get my user info');
        utterances.add('get my user');
        utterances.add('my user');
        utterances.add('user info');
        this.setUtterances(utterances);
    }
    
    public override ASkillResponse execute(ASkillRequest request){
        
        /*
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        //change this with your current community folder name (or leave blank string)
        String communityFolder = '/alexaforce';
        String endpoint = URL.getSalesforceBaseUrl().toExternalForm()+communityFolder+'/services/Soap/c/34.0';
        req.setMethod('POST');
        req.setEndpoint(endpoint);
        req.setHeader('Content-Type', 'text/xml; charset=utf-8');
        req.setHeader('SOAPAction','getUserInfo');
        
        String authToken = request.session.user.accessToken;
        
        String soapBody = '<?xml version="1.0" encoding="utf-8"?><soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:enterprise.soap.sforce.com">  <soapenv:Header><urn:SessionHeader><urn:sessionId>'
                    +authToken+'</urn:sessionId></urn:SessionHeader></soapenv:Header><soapenv:Body><urn:getUserInfo /></soapenv:Body></soapenv:Envelope>';
        
        req.setBody(soapBody);
        HttpResponse resp = h.send(req);
        system.debug('## Request body: '+soapBody);
        system.debug('## Response body: '+resp.getBody());
        Dom.Document doc = resp.getBodyDocument();
        //Retrieve the root element for this document.
        Dom.XMLNode soapenvEnvelope  = doc.getRootElement();
        String SOAPENV_NS = 'http://schemas.xmlsoap.org/soap/envelope/';
        String NS = 'urn:enterprise.soap.sforce.com';
        Dom.XMLNode bodyNode = soapenvEnvelope.getChildElement('Body', SOAPENV_NS);
        Dom.XMLNode userinfoRespNode = bodyNode.getChildElement('getUserInfoResponse', NS);
        Dom.XMLNode resultNode = userinfoRespNode.getChildElement('result', NS);
        Dom.XMLNode fullnameNode = resultNode.getChildElement('userFullName',NS);
        Dom.XMLNode userIdNode = resultNode.getChildElement('userId',NS);
        String fullName = fullnameNode.getText();
        String userId = userIdNode.getText();
        String responseText = 'Your user\'s full name is '+fullName;
        return this.say(responseText, 'Salesforce User Info', responseText, null, true);
        */
        
        // create a case based on the data that the user had sent
        Case newCase = new Case();
        newCase.Subject='This should come from request';
        //insert newCase;
        System.debug('\n\n-------------Case:'+newCase);
        System.debug('\n\n-------------Case Number:'+newCase.CaseNumber);
        List<Case> cases = new List<Case>();
        cases = [SELECT id, CaseNumber,Subject FROM case limit 1];
        //return this.say('New Case has been created. Please use case number :'+ cases[0].CaseNumber +' for further communication', 'Title', 'Inteygrate two', null, false);
        
        List<Lead> leads = new List<Lead>();
        leads = [SELECT id, Name FROM Lead limit 1];
        Lead newLead = new Lead();
        newLead.LastName = request.request.intent.slots.get('LeadName').value;
        newLead.Company= request.request.intent.slots.get('LeadName').value;
        //newLead.ownerId = userId;
        insert newLead;
        /*Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(newLead.id);
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
        lc.setConvertedStatus(convertStatus.MasterLabel);
        
        Database.LeadConvertResult lcr = Database.convertLead(lc);*/
        return this.say('New Lead '+request.request.intent.slots.get('LeadName').value,false, 'Lead Created', request.request.intent.slots.get('LeadName').value, 'New Lead '+request.request.intent.slots.get('LeadName').value+' has been created', false,false);
        
        
        
        
    }
    

}