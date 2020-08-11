public class AccountController2 {
    private ApexPages.StandardController sc;
    public AccountController2(ApexPages.StandardController sc) {
        this.sc = sc;
    }
    public PageReference save() {
        PageReference detailPage = sc.save();
        if (detailPage != null) {
            PageReference editPage = new PageReference('/apex/AccountList2');
            return editPage;
        } else {
            return detailPage;
        }
    }
}