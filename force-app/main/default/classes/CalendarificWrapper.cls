public class CalendarificWrapper {
    public Meta meta {get;set;} 
	public Response response {get;set;} 
	public class Response {
		public List<Holidays> holidays {get;set;} 

		public Response(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'holidays') {
							holidays = arrayOfHolidays(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Response consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Meta {
		public Integer code {get;set;} 

		public Meta(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'code') {
							code = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Meta consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Holidays {
		public String name {get;set;} 
		public String description {get;set;} 
		public Date_Z date_Z {get;set;} // in json: date
		public List<String> type {get;set;} 

		public Holidays(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'name') {
							name = parser.getText();
						} else if (text == 'description') {
							description = parser.getText();
						} else if (text == 'date') {
							date_Z = new Date_Z(parser);
						} else if (text == 'type') {
							type = arrayOfString(parser);
						} else {
							//System.debug(LoggingLevel.WARN, 'Holidays consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}

	public CalendarificWrapper(JSONParser parser) {
		while (parser.nextToken() != System.JSONToken.END_OBJECT) {
			if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
				String text = parser.getText();
				if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
					if (text == 'meta') {
						meta = new Meta(parser);
					} else if (text == 'response') {
						response = new Response(parser);
					} else {
						System.debug(LoggingLevel.WARN, 'CalendarificWrapper consuming unrecognized property: '+text);
						consumeObject(parser);
					}
				}
			}
		}
	}
	
	public class Datetime_Z {
		public Integer year {get;set;} 
		public Integer month {get;set;} 
		public Integer day {get;set;} 

		public Datetime_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'year') {
							year = parser.getIntegerValue();
						} else if (text == 'month') {
							month = parser.getIntegerValue();
						} else if (text == 'day') {
							day = parser.getIntegerValue();
						} else {
							System.debug(LoggingLevel.WARN, 'Datetime_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public class Date_Z {
		public String iso {get;set;} 
		public Datetime_Z datetime_Z {get;set;} // in json: datetime

		public Date_Z(JSONParser parser) {
			while (parser.nextToken() != System.JSONToken.END_OBJECT) {
				if (parser.getCurrentToken() == System.JSONToken.FIELD_NAME) {
					String text = parser.getText();
					if (parser.nextToken() != System.JSONToken.VALUE_NULL) {
						if (text == 'iso') {
							iso = parser.getText();
						} else if (text == 'datetime') {
							datetime_Z = new Datetime_Z(parser);
						} else {
							System.debug(LoggingLevel.WARN, 'Date_Z consuming unrecognized property: '+text);
							consumeObject(parser);
						}
					}
				}
			}
		}
	}
	
	public static CalendarificWrapper parse(String json) {
		System.JSONParser parser = System.JSON.createParser(json);
		return new CalendarificWrapper(parser);
	}
	
	public static void consumeObject(System.JSONParser parser) {
		Integer depth = 0;
		do {
			System.JSONToken curr = parser.getCurrentToken();
			if (curr == System.JSONToken.START_OBJECT || 
				curr == System.JSONToken.START_ARRAY) {
				depth++;
			} else if (curr == System.JSONToken.END_OBJECT ||
				curr == System.JSONToken.END_ARRAY) {
				depth--;
			}
		} while (depth > 0 && parser.nextToken() != null);
	}

    private static List<String> arrayOfString(System.JSONParser p) {
        List<String> res = new List<String>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(p.getText());
        }
        return res;
    }

    private static List<Holidays> arrayOfHolidays(System.JSONParser p) {
        List<Holidays> res = new List<Holidays>();
        if (p.getCurrentToken() == null) p.nextToken();
        while (p.nextToken() != System.JSONToken.END_ARRAY) {
            res.add(new Holidays(p));
        }
        return res;
    }
}