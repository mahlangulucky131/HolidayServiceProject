public with sharing class HolidayServiceControllerv2 {

    public Id_Number_Search__c idNumberSearch { get; private set; }

    public HolidayServiceControllerv2() {
        Id id = ApexPages.currentPage().getParameters().get('id');
        idNumberSearch = (id == null) ? new Id_Number_Search__c() : 
            [SELECT Id, ID_Number__c FROM Id_Number_Search__c WHERE Id = :id];
    }

    public PageReference save() {
        try {
            upsert(idNumberSearch);
        } catch(System.DMLException e) {
            ApexPages.addMessages(e);
            return null;
        }
        //  After successful Save, navigate to the default view page
        PageReference redirectSuccess = new ApexPages.StandardController(idNumberSearch).view();
        return (redirectSuccess);
    }
}