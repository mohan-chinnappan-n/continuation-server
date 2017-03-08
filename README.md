## Sample usage for Salesforce Continuation Server


[Reference] (https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_continuation_overview.htm?search_text=continuation%20server)

A user invokes an action on a Visualforce page that requests information from a Web service (step 1).

The app server hands the callout request to the Continuation server before returning to the Visualforce page (steps 2–3).

The Continuation server sends the request to the Web service and receives the response (steps 4–7), then hands the response back to the app server (step 8). 

Finally, the response is returned to the Visualforce page (step 9).



![Flow](https://developer.salesforce.com/docs/resources/img/en-us/204.0?doc_id=dev_guides%2Fapex%2Fimages%2Fapex_continuations_diagram.png&folder=apexcode)

### Demo

#### Use case

Four serial actions calling continuation; each continuation got 3 parallel callouts; so total: 4 * 3 = 12 callouts

![Demo](./img/continuation-server-example.gif)


