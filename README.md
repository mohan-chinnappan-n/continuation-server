## Sample usage for Salesforce Continuation Server


[Reference] (https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_continuation_overview.htm?search_text=continuation%20server)


![Flow](https://developer.salesforce.com/docs/resources/img/en-us/204.0?doc_id=dev_guides%2Fapex%2Fimages%2Fapex_continuations_diagram.png&folder=apexcode)

### Demo

#### Use case

Four serial actions calling continuation; each continuation got 3 parallel callouts; so total: 4 * 3 = 12 callouts

![Demo](./img/continuation-server-example.gif)


