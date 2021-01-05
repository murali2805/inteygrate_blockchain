public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer n,String lastname){
        List<Contact> contactList = new List<Contact>();
        for(integer i=0;i<n;i++){
            Contact c = new Contact(LastName=lastname,FirstName='firstname'+i);
            contactList.add(c);
        }
        
        return contactList;
    }
}