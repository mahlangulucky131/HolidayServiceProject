trigger IdNumberSearch on Id_Number_Search__c (before insert, before update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        for(Id_Number_Search__c newRecord: Trigger.new){
            if(trigger.oldMap.get(newRecord.Id).LastModifiedById != newRecord.LastModifiedById ){
            newRecord.Searches__c++;
            }
        }
    }
    
}