global class DailyLeadProcessor implements Schedulable{
	global void execute(SchedulableContext sc){
        List<Lead> leads = [select id,LeadSource from Lead where LeadSource=''];
        for(Lead l:leads){
            l.LeadSource = 'Dreamforce';
            //leads.add(l);
        }
        update leads;
    }
}