---
layout: post
title:  "Getting Started with ArangoDB"
date:   2016-06-16 23:11:21 +0000
categories: arangodb
---
After some research and fiddling, I decided that the run of the mill relational database might
not be the most ideal for storing and searching the type of data we're going to have hear at
Bandheap. I knew from experience that a standard NoSQL database wouldn't cut it either because
of the need for relationships.

This is when I stumbled on graph databases and started mocking up the data feeds into [Neo4j][1]
which is the most popular. It worked much nicer for this project than a relational database but the
pricing concerns gave me pause. I've seen references to the cost starting at $18,000 a year. That's
when I found [ArangoDB][2]. There is a lot of stumbling blocks with the smaller community which
leads to less documentation and examples. I initially implemented the cities and postal codes data
just as I did in Neo4j which is when I realized a huge advantage that ArangoDB has over other
data stores. It can function as a document store, graph database or key-value store. The queries to
find cities in postal codes were kind of convoluted for such simple functionality. That's when I
stepped away from my normalized relational world and added the postal codes as an array inside
of a city document. There may be a handful of duplicates for those postal codes that exist in
multiple cities but that's one of the trade offs.

I started with a Python script that pulled data from [GeoNames][3] and generated JSON to be imported
to Arango with the `arangoimp` command. Here's a sample of an individual city with multiple
postal codes.

~~~ json
{
   "label":"Allentown, PA",
   "name":"Allentown",
   "country_code":"US",
   "postal_codes":[
      {
         "location":[
            40.6026,
            -75.4691
         ],
         "postal_code":"18101"
      },
      {
         "location":[
            40.6068,
            -75.4781
         ],
         "postal_code":"18102"
      },
      {
         "location":[
            40.5891,
            -75.4645
         ],
         "postal_code":"18103"
      },
      {
         "location":[
            40.6018,
            -75.5225
         ],
         "postal_code":"18104"
      },
      {
         "location":[
            40.6934,
            -75.4712
         ],
         "postal_code":"18105"
      },
      {
         "location":[
            40.5824,
            -75.5911
         ],
         "postal_code":"18106"
      },
      {
         "location":[
            40.6366,
            -75.4405
         ],
         "postal_code":"18109"
      },
      {
         "location":[
            40.5843,
            -75.6248
         ],
         "postal_code":"18195"
      }
   ],
   "_key":"US768196",
   "state":"PA"
}
~~~

Once this is imported into the *cities* collection, the following query will select from the
subdocument array.

~~~
FOR c IN cities
    FILTER '18104' IN c.postal_codes[*].postal_code AND c.country_code == 'US'
    RETURN c
~~~

Unfortunately, with over 700,000 records worldwide, this took 1.528s. We need an index. This is one
of those things that took some digging with the smaller user base that Arango has.

~~~ javascript
db.cities.ensureIndex({type: "hash", fields: ["country_code", "postal_codes[*].postal_code"]});
~~~

0.003s. That's more like it.

I added this to my database initialization script which I run through `arangosh` via the
`--javascript.executable` parameter

~~~ javascript
'use strict';

if (db._databases().indexOf("bandheap") == -1) {
    db._createDatabase("bandheap");
}

db._useDatabase("bandheap");

checkForCollection("cities");

db.cities.ensureIndex({type: "hash", fields: ["name", "state", "country_code"], unique: true});
db.cities.ensureIndex({type: "hash", fields: ["country_code", "postal_codes[*].postal_code"]});
db.cities.ensureIndex({type: "geo", fields: ["postal_codes.location"]});

function checkForCollection(collection, is_edge=false) {
    if (!db._collection(collection)) {
        if (is_edge) {
            db._createEdgeCollection(collection);
        } else {
            db._createDocumentCollection(collection);
        }
    }
}
~~~

The code for this and a sample JSON file can be found in [this GitHub repository][4]

[1]: http://neo4j.com
[2]: https://www.arangodb.com/
[3]: http://www.geonames.org/
[4]: https://github.com/andybarilla/arangodb-geonames

