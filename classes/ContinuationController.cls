public with sharing class ContinuationController {

    public List<String> serials{get;set;} 
     
    
    // Unique label corresponding to the continuation
    public List<String> requestLabels{get;set;}
    
    // Result of callout
    public List<String> results{get;set;} 
     
    // we will simulate long-running service by asking service 
    // to sleep for this many seconds
    private static final Integer SLEEP = 1;
    private static final Integer NUM_PARALLELS = 3;
       
    // Callout endpoint as a named credential URL 
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL = 
        'https://mohansun-blueconnect-api.herokuapp.com/api/dsw/' + SLEEP;
    
    
    // Constructor
    public  ContinuationController() {
      serials = new List<String> { '1s', '2s', '3s', '4s' };
    }
    
    // Action method
    public Object startRequest() {
       
      // Create continuation with a timeout
      Integer to = Integer.valueOf( ApexPages.currentPage().getParameters().get('to') );
      Continuation con = new Continuation(to);
     
      this.requestLabels = new  List<String> { 'one', 'two', 'three' };
      this.results = new  List<String>{ 'one', 'two', 'three' };
      
      
      
      
      // Create callout request
      List<HttpRequest> reqs = new List<HttpRequest>(NUM_PARALLELS );
      for (Integer p = 0; p < NUM_PARALLELS ; p++) {
      
          
          // Set callback method
          con.continuationMethod='processResponse';
          reqs[p] = new HttpRequest();
          reqs[p].setMethod('GET');
          reqs[p].setEndpoint(LONG_RUNNING_SERVICE_URL);
          
          // Add callout request to continuation
          this.requestLabels[p] = con.addHttpRequest(reqs[p]);
        }
      
      // Return the continuation
      return con;  
    }
    
    // Callback method 
    public Object processResponse() {   
    
     for (Integer p = 0; p < NUM_PARALLELS ; p++) {
      
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabels[p]);
      // Set the result variable that is displayed on the Visualforce page
      this.results[p] = p + ': ' + response.getBody();
     }
      
      // Return null to re-render the original Visualforce page
      return null;
    }
}
