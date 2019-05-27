Create a specific json list structure from R lists

When dealing with list structures like your JSON file, it
is better to use Python or R. Both have native support for list structures.

Another reason SAS needs better integration with R, Python and PERL

github
https://tinyurl.com/yyr5wnwh
https://github.com/rogerjdeangelis/utl-create-a-specific-json-list-structure-from-R-lists

SAS Forum
https://communities.sas.com/t5/SAS-Programming/JSON-Hierarchy-in-SAS/m-p/561654

*                _     _
 _ __  _ __ ___ | |__ | | ___ _ __ ___
| '_ \| '__/ _ \| '_ \| |/ _ \ '_ ` _ \
| |_) | | | (_) | |_) | |  __/ | | | | |
| .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
|_|
;

 Create the following specific JSON structure

 [
  {
      "Entity" : "Purchase",
      "TransactionID"  : "20190110_AC879",
      "Fields" : {
                     "type" : "Individual",
                     "full_nam" : "Bob Lee",
                     "item_code" : "BV9849",
                     "amt_prItem" : "99.99"
                    }
 },
 {
    "Entity" : "Purchase",
      "TransactionID"  : "20190123_ZR067",
      "Fields" : {
                     "type" : "Individual",
                     "full_nam" : "Sarah Doe",
                     "item_code" : "BV8549",
                     "amt_prItem" : "15.09"
                    }
}
]

*_                   _
(_)_ __  _ __  _   _| |_
| | '_ \| '_ \| | | | __|
| | | | | |_) | |_| | |_
|_|_| |_| .__/ \__,_|\__|
        |_|
;

* it is fairly easy to create the list structure below
* I used dput on the imported json file
* but R and python have many ways to create lists;

%utl_submit_r64('
lst = structure(list(
         Entity        = c("Purchase", "Purchase"),
         TransactionID = c("20190110_AC879","20190123_ZR067"),
            Fields =
              structure(list(
                type       = c("Individual","Individual"),
                full_nam   = c("Bob Lee", "Sarah Doe"),
                item_code  = c("BV9849","BV8549"),
                amt_prItem = c("99.99", "15.09")
           ),
           class = "data.frame",row.names = 1:2)
         ),
      class = "data.frame",row.names = 1:2)
;
lst;
');

 * proc ontents on lst;

'data.frame':	2 obs. of  3 variables:
 $ Entity       : chr  "Purchase" "Purchase"
 $ TransactionID: chr  "20190110_AC879" "20190123_ZR067"
 $ Fields       :'data.frame':	2 obs. of  4 variables:
  ..$ type      : chr  "Individual" "Individual"
  ..$ full_nam  : chr  "Bob Lee" "Sarah Doe"
  ..$ item_code : chr  "BV9849" "BV8549"
  ..$ amt_prItem: chr  "99.99" "15.09"


This is what a list looks lile when printed

    Entity   TransactionID  Fields.type  Fields.full_nam  Fields.item_code   Fields.amt_prItem

1 Purchase  20190110_AC879   Individual          Bob Lee            BV9849               99.99
2 Purchase  20190123_ZR067   Individual        Sarah Doe            BV8549               15.09

*            _               _
  ___  _   _| |_ _ __  _   _| |_
 / _ \| | | | __| '_ \| | | | __|
| (_) | |_| | |_| |_) | |_| | |_
 \___/ \__,_|\__| .__/ \__,_|\__|
                |_|
;

[
  {
    "Entity": "Purchase",
    "TransactionID": "20190110_AC879",
    "Fields": {
      "type": "Individual",
      "full_nam": "Bob Lee",
      "item_code": "BV9849",
      "amt_prItem": "99.99"
    }
  },
  {
    "Entity": "Purchase",
    "TransactionID": "20190123_ZR067",
    "Fields": {
      "type": "Individual",
      "full_nam": "Sarah Doe",
      "item_code": "BV8549",
      "amt_prItem": "15.09"
    }
  }
]

*
 _ __  _ __ ___   ___ ___  ___ ___
| '_ \| '__/ _ \ / __/ _ \/ __/ __|
| |_) | | | (_) | (_|  __/\__ \__ \
| .__/|_|  \___/ \___\___||___/___/
|_|
;

%utl_submit_r64('
library(jsonlite);
lst = structure(list(
         Entity        = c("Purchase", "Purchase"),
         TransactionID = c("20190110_AC879","20190123_ZR067"),
            Fields =
              structure(list(
                type       = c("Individual","Individual"),
                full_nam   = c("Bob Lee", "Sarah Doe"),
                item_code  = c("BV9849","BV8549"),
                amt_prItem = c("99.99", "15.09")
           ),
           class = "data.frame",row.names = 1:2)
         ),
      class = "data.frame",row.names = 1:2)
;
lst;
jsonlst<-toJSON(lst);
sink("d:/json/want.json");
prettify(jsonlst,indent=2);
sink();
');



