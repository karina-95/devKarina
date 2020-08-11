public abstract class TestDataFactory {
 
    //Account creation
    
    public static List<Account> createAccounts() {
        
        List<Account> accounts = new List<Account>();
        
            
            Account account = new Account( Name = 'Test Account1',
                                           Phone= '(415) 419-8873');                                       
            
            accounts.add(account);
            
        
        
        return accounts;
        
    }
    
    public static List<Contact> createContacts( Account acct) {
        
        List<Contact> contacts = new List<Contact>();
        
            Contact con = new Contact( firstname = 'Test Contact1',
                                       lastname= 'Test Contact2',
                                       AccountId = acct.Id,
                                       Phone= '(415) 419-8873');                                       
            
            contacts.add(con);
            
        
        
        return contacts;
        
    }
    
}