
// On Salesforce create a Site to expose this class

@RestResource(urlMapping = '/Arduino_Humidity__c/*')
global class RealTimeDataService {
    @HttpGET
    global static void doGet() {
        //Set the response as plaintext
        RestContext.response.addHeader('Content-Type', 'text/plain');
        //Get the Humidity value from the parameter
        String reading = RestContext.request.params.get('humidity');
        
        //Convert the string value to Double
        Double doubleReading = Double.valueOf(reading);
        
        //Create a new custob object record to store the value
        Arduino_Humidity__c record = new Arduino_Humidity__c();
        // Get Corect Date Time
        Datetime local = Datetime.now();
        record.Date_Time__c = local;
        //String[] spl = String.valueOfGmt(record.Date_Time__c).split('/,'); //Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSSZ')
        record.Name = String.valueOfGmt(local);//spl[1];
        record.Up_Gurden__c = doubleReading;
        
        try {
            //Insert the temperature value, if success, send success response
            insert record;
            RestContext.response.responseBody = Blob.valueOf('success');
        } catch (Exception ex) {
            //If the insertion fails, send error response
            RestContext.response.responseBody = Blob.valueOf('error');
        }
    }
}
