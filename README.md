## Sample usage for Salesforce Continuation Server


[Reference](https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_continuation_overview.htm?search_text=continuation%20server)

A user invokes an action on a Visualforce page that requests information from a Web service (step 1).

The app server hands the callout request to the Continuation server before returning to the Visualforce page (steps 2–3).

The Continuation server sends the request to the Web service and receives the response (steps 4–7), then hands the response back to the app server (step 8). 

Finally, the response is returned to the Visualforce page (step 9).



![Flow](https://developer.salesforce.com/docs/resources/img/en-us/204.0?doc_id=dev_guides%2Fapex%2Fimages%2Fapex_continuations_diagram.png&folder=apexcode)

### Demo

#### Use case

Four serial actions calling continuation; each continuation got 3 parallel callouts; so total: 4 * 3 = 12 callouts

![Demo](./img/continuation-server-example.gif)


## Simple use 

### Visutalforce page

```xml
<apex:page controller="ContinuationController" showChat="false" showHeader="false">
   <apex:form >
      <!-- Invokes the action method when the user clicks this button. -->
      <apex:commandButton action="{!startRequest}" 
              value="Start Request" reRender="result"/> 
   </apex:form>

   <!-- This output text component displays the callout response body. -->
   <apex:outputText id="result" value="{!result}" />
</apex:page>

```
### Controller

```java

public with sharing class ContinuationController {
    // Unique label corresponding to the continuation
    public String requestLabel;
    // Result of callout
    public String result {get;set;}
    // Callout endpoint as a named credential URL 
    // or, as shown here, as the long-running service URL
    private static final String LONG_RUNNING_SERVICE_URL = 
        '<Insert your service URL>';
   
   // Action method
    public Object startRequest() {
      // Create continuation with a timeout
      Continuation con = new Continuation(40);
      // Set callback method
      con.continuationMethod='processResponse';
      
      // Create callout request
      HttpRequest req = new HttpRequest();
      req.setMethod('GET');
      req.setEndpoint(LONG_RUNNING_SERVICE_URL);
      
      // Add callout request to continuation
      this.requestLabel = con.addHttpRequest(req);
      
      // Return the continuation
      return con;  
    }
    
    // Callback method 
    public Object processResponse() {   
      // Get the response by using the unique label
      HttpResponse response = Continuation.getResponse(this.requestLabel);
      // Set the result variable that is displayed on the Visualforce page
      this.result = response.getBody();
      
      // Return null to re-render the original Visualforce page
      return null;
    }
}
```

### Limits

<table class="featureTable sort_table" summary="">
<thead class="thead sorted" align="left">
<tr>
<th class="featureTableHeader vertical-align-top " id="d16039e63">Description</th>

<th class="featureTableHeader vertical-align-top " id="d16039e66">Limit</th>

</tr>

</thead>

<tbody class="tbody">
<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum number of parallel Apex callouts in a single
        continuation</td>

<td class="entry" headers="d16039e66" data-title="Limit">3</td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum number of chained Apex callouts</td>

<td class="entry" headers="d16039e66" data-title="Limit">3</td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum timeout for a single continuation<sup class="ph sup">1</sup>
</td>

<td class="entry" headers="d16039e66" data-title="Limit"><span class="ph" id="cont_timeout"><a name="cont_timeout"><!-- --></a>120 seconds</span></td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum Visualforce controller-state
         size<sup class="ph sup">2</sup>
</td>

<td class="entry" headers="d16039e66" data-title="Limit">80 KB</td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum HTTP response size</td>

<td class="entry" headers="d16039e66" data-title="Limit">1 MB</td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum HTTP POST form size—the size of all keys and
values in the form<sup class="ph sup">3</sup>
</td>

<td class="entry" headers="d16039e66" data-title="Limit">1 MB</td>

</tr>

<tr>
<td class="entry" headers="d16039e63" data-title="Description">Maximum number of keys in the HTTP POST form<sup class="ph sup">3</sup>
</td>

<td class="entry" headers="d16039e66" data-title="Limit">500</td>

</tr>

</tbody>

</table>
