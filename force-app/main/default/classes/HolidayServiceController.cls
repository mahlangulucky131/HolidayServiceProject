public with sharing class HolidayServiceController {
    @AuraEnabled
    public static Id_Number_Search__c idNumberSearch{get;set;}

    public HolidayServiceController() {
        
    }
    @AuraEnabled
    public Static List<Id_Number_Search__c> getidNumberSearch(String searchIDNum) {
        List<Id_Number_Search__c> idNumbers = new List<Id_Number_Search__c>();
        
        //idNumberSearch =  [SELECT Id, ID_Number__c, Searches__c FROM Id_Number_Search__c  WHERE ID_Number__c=: searchIDNum]; 
        idNumberSearch = new Id_Number_Search__c(ID_Number__c=searchIDNum);
        system.debug('Line 14: idNumberSearch'+idNumberSearch);
        if(idNumberSearch != null) {
        try{
            system.debug('Line 17: try block: '+idNumberSearch);
            idNumberSearch.Searches__c = +1;
            idNumbers.add(idNumberSearch);
        }
        catch(Exception e){
            system.debug('Line 20: catch block: '+idNumberSearch);
            system.debug('Line 20: catch block: '+e.getMessage());
            throw new CustomException(e.getMessage());
            }
        }
        else if(idNumberSearch == null){
            idNumberSearch = new Id_Number_Search__c(ID_Number__c=searchIDNum);
            idNumbers.add(idNumberSearch);
            system.debug('Line 30: else block: '+idNumberSearch);
        }
        return idNumbers;
    }

    @AuraEnabled
    public static List<Id_Number_Search__c> updateIdNumberSearches(List<Id_Number_Search__c> IdsToUpdate) {
        system.debug('Line 37: updateIdNumberSearches method : '+IdsToUpdate);
        List<Id_Number_Search__c> updateListNums = new List<Id_Number_Search__c>();
        try{
            system.debug('Line 40: updateIdNumberSearches try method : '+IdsToUpdate);
            for(Id_Number_Search__c item: IdsToUpdate){
            item.Searches__c++;
            item.Response__c = 'Id Number Searched, updated'+ System.Datetime.Now();
            updateListNums.add(item);
            }

            upsert updateListNums ID_Number__c;
        }
        catch(Exception e){
            system.debug('Line 45: Exceptions try method : '+ e.getMessage());

            throw new CustomException('Error encountered to update IdNumber: '+ e.getMessage());
        }
        return updateListNums;
    }

    public class CustomException extends Exception {

    }
}