public class PaginationNumberController {
    
    private integer counter=0;  
    private integer list_size=20; 
    public integer total_size; 
    String paramValue;
    public String getParamValue(){
        return paramValue;
    }
    
    public void setParamValue(String paramValue){
        this.paramValue = paramValue;
    }

    public string selectedPage{get; set;}
    public List<Contact> conList {get;set;}
    
    public PaginationNumberController() {
        total_size = [select count() from Account]; 
        selectedPage='0';
    }
    
    public Account[] getAccount() {
        
        if (selectedPage != '0')
            counter = list_size*integer.valueOf(selectedPage)-list_size;
        try { 
            Account[] acct = [select Name, Phone 
                              from Account 
                              order by CreatedDate
                              limit :list_size
                              offset :counter];                   
            return acct;
            
        } catch (QueryException e) {                            
            ApexPages.addMessages(e);                   
            return null;
        }        
    }
    
    public Component.Apex.pageBlockButtons getMyCommandButtons() {
        
        Set<string> theSet = new Set<string>();
        theSet.add('myPanel');
        theSet.add('myButtons');
        
        integer totalPages;
        if (math.mod(total_size, list_size) > 0) {
            totalPages = total_size/list_size + 1;
        } else {
            totalPages = (total_size/list_size);
        }
        
        integer currentPage;        
        if (selectedPage == '0') {
            currentPage = counter/list_size + 1;
        } else {
            currentPage = integer.valueOf(selectedPage);
        }
        
        Component.Apex.pageBlockButtons pbButtons = new Component.Apex.pageBlockButtons();        
        pbButtons.location = 'top';
        pbButtons.id = 'myPBButtons';
        
        Component.Apex.outputPanel opPanel = new Component.Apex.outputPanel();
        opPanel.id = 'myButtons';
        
        //the Previous button will always be displayed
        Component.Apex.commandButton b1 = new Component.Apex.commandButton();
        b1.expressions.action = '{!Previous}';
        b1.title = 'Previous';
        b1.value = 'Previous';
        b1.expressions.disabled = '{!disablePrevious}';        
        b1.reRender = theSet;
        
        opPanel.childComponents.add(b1);        
        
        for (integer i=0;i<totalPages;i++) {
            Component.Apex.commandButton btn = new Component.Apex.commandButton();
            
            if (i+1==1) {
                btn.title = '1';
                btn.value = '1';
                btn.rendered = true;                                        
            } 
            else {
                btn.title = 'Page ' + string.valueOf(i+1) + ' ';
                btn.value = ' ' + string.valueOf(i+1) + ' ';
                btn.rendered = false;             
            }
            
            if ((i+1 <= 5 && currentPage < 5)
                || (i+1 >= totalPages-4 && currentPage > totalPages-4)
                || (i+1 >= currentPage-2 && i+1 <= currentPage+2))
            {
                btn.rendered = true;
            }
            
            if (i+1==currentPage) {
                btn.disabled = true; 
                btn.style = 'color:blue;';
            }  
            
            btn.onclick = 'queryByPage(\''+string.valueOf(i+1)+'\');return false;';
            
            opPanel.childComponents.add(btn);
            
            if (i+1 == totalPages-1) { 
                Component.Apex.outputText text = new Component.Apex.outputText();
                text.value = '...';        
                opPanel.childComponents.add(text);
            } 
            
        }
        
        //the Next button will always be displayed
        Component.Apex.commandButton b2 = new Component.Apex.commandButton();
        b2.expressions.action = '{!Next}';
        b2.title = 'Next';
        b2.value = 'Next';
        b2.expressions.disabled = '{!disableNext}';        
        b2.reRender = theSet;
        opPanel.childComponents.add(b2);
        
        pbButtons.childComponents.add(opPanel);  
        
        return pbButtons;
        
    }    
    
    public PageReference refreshGrid() {       
        system.debug('**** ' + selectedPage);
        return null;
    }
    
    public PageReference Previous() { 
        selectedPage = '0';
        counter -= list_size;
        return null;
    }
    
    public PageReference Next() { 
        selectedPage = '0';
        counter += list_size;
        return null;
    }
    
    
    
    public Boolean getDisablePrevious() { 
        if (counter>0) 
            return false;
        else return true;
    }
    
    public Boolean getDisableNext() { 
        if (counter + list_size < total_size)
            return false;
        else return true;
    }
    
    public Integer getTotal_size() {
        return total_size;
    }
    
    public Integer getPageNumber() {
        return counter/list_size + 1;
    }
    
    public Integer getTotalPages() {
        if (math.mod(total_size, list_size) > 0) {
            return total_size/list_size + 1;
        } else {
            return (total_size/list_size);
        }
    }
    
    
    public PageReference ContactLists()
        
    {
        if(ApexPages.currentPage().getParameters().get('id') != null){
            
            conList = [Select id,Name,Phone,Email from Contact where accountId =: ApexPages.currentPage().getParameters().get('id')];
            system.debug(+conList);
            system.debug(ApexPages.currentPage().getParameters().get('id'));
        }
        return null;
        
    } 
    
  
}