public with sharing class CalendarificWrapperRetriever {

    @AuraEnabled
    public static String getCalendarificData(String Idyear) {

    String convertedYear;
    Integer convertedYearNum;

    if(Idyear != null)
        convertedYearNum = Integer.valueOf(Integer.valueOf(Idyear.left(2)) < 99? '19' + Idyear.left(2)  : '20' + Idyear.left(2));
    
    List<CalendarificWrapper.Holidays> queriedHolidays = new List<CalendarificWrapper.Holidays>();

    String params = '?&api_key=24c5e86734eb44dc4a962826324a5546e74dc42f&country=ZA&year='+ convertedYearNum+'&type=national';
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    request.setEndpoint('https://calendarific.com/api/v2/holidays'+ params);
    request.setMethod('GET');
	HttpResponse response;

	try{
      response = http.send(request);
	}
	catch(Exception e) {
		system.debug('Exception: '+e.getMessage());
	}
    // If the request is successful, parse the JSON response.
    if(response.getStatusCode() == 200) {
        Related_Holiday__c pHoliday;
        List<Related_Holiday__c> pHolidays = new List<Related_Holiday__c>();
        CalendarificWrapper calendarificResponse = CalendarificWrapper.parse(response.getBody());
        queriedHolidays = calendarificResponse.Response.holidays;
        System.debug('Received the following Holidays:');
        for(CalendarificWrapper.Holidays holiday: queriedHolidays) {
            System.debug(holiday.name);
            System.debug(holiday.description);
            System.debug(holiday.date_Z);
            System.debug(holiday.type);
        }
    }   
    System.debug('queriedHolidays: '+ queriedHolidays.size());

    return JSON.serialize(queriedHolidays);
    }
}