@isTest
public class TestAccountList {
    
    
    @IsTest
    public static void testAccountList() {
        PaginationNumberController c = new PaginationNumberController(); 
        Account acct=new Account();
        Contact con=new Contact();
        acct = TestDataFactory.createAccounts()[0];
        
        insert acct;
        con = TestDataFactory.createContacts(acct)[0];
        
        insert con;
        
        
        system.debug('Account Id'+acct.id);
        
        acct = [select Name, Phone from Account where id = :acct.id];
        
        system.assertEquals(acct.name, 'Test Account1');
        
        c.getAccount();    
        c.getDisableNext();
        c.getDisablePrevious();
        c.getTotal_size();
        c.Next();
        c.Previous();  
        c.getMyCommandButtons();
        c.SelectedPage='10';
        c.total_size=50;
        c.refreshGrid();        
        c.getMyCommandButtons(); 
        c.getPageNumber();
        c.getTotalPages();   
        c.ContactLists();
    }    
    
    
}