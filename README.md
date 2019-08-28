# README

Clone
``` 
git clone git@github.com:primableatom/location_detector.git
```
Bundle
```
bundle install
```
Database
```
rake db:create
rake db:migrate
rake db:seed
```
Devlopment Server

```
rails s
```

Access server at localhost:3000
Access sidekiq UI at localhost:3000/sidekiq

Sidekiq Worker command

```
sidekiq
```
## API

### Access tokens
Request
GET
```
<SERVER_URL>/api/v1/access_tokens/
```
Response
[{
"access_tokens": [
<access_token>
]
}]
##### PS: Take one of the access tokens and pass it to other API's as parameter

### Features
GET
Request
```
<SERVER_URL>/api/v1/features
Params:
access_token: <access_token>	 
```
Response
```
{
"type": "FeatureCollection",
"features": [
{
"id": 18,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"7.36084",
"50.666872"
],
[
"8.195801",
"49.823809"
],
[
"10.634766",
"50.190968"
],
[
"10.722656",
"51.481383"
],
[
"8.76709",
"51.522416"
],
[
"7.36084",
"50.666872"
]
]
}
},
{
"id": 19,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"12.32666",
"48.107431"
],
[
"12.062988",
"48.063397"
],
[
"12.546387",
"46.664517"
],
[
"14.39209",
"49.181703"
],
[
"16.45752",
"49.15297"
],
[
"16.984863",
"46.679594"
],
[
"18.413086",
"46.589069"
],
[
"18.259277",
"50.120578"
],
[
"13.886719",
"50.120578"
],
[
"12.32666",
"48.107431"
]
]
}
},
{
"id": 20,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"-0.637207",
"44.418088"
],
[
"0.263672",
"41.95132"
],
[
"4.746094",
"41.820455"
],
[
"4.96582",
"43.92955"
],
[
"-0.637207",
"44.418088"
]
]
}
},
{
"id": 21,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"-88.242187",
"38.822591"
],
[
"-89.25293",
"32.138409"
],
[
"-81.826172",
"31.840233"
],
[
"-80.727539",
"37.335224"
],
[
"-82.529297",
"41.079351"
],
[
"-88.242187",
"38.822591"
]
]
}
},
{
"id": 22,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"-119.619141",
"33.578015"
],
[
"-113.378906",
"30.902225"
],
[
"-105.996094",
"31.128199"
],
[
"-105.292969",
"32.990236"
],
[
"-105.820313",
"35.029996"
],
[
"-106.962891",
"35.317366"
],
[
"-108.544922",
"35.532226"
],
[
"-114.082031",
"35.38905"
],
[
"-118.564453",
"38.134557"
],
[
"-120.585937",
"42.293564"
],
[
"-120.410156",
"45.089036"
],
[
"-118.476562",
"46.619261"
],
[
"-116.015625",
"47.040182"
],
[
"-110.478516",
"46.980252"
],
[
"-107.841797",
"44.902578"
],
[
"-105.996094",
"40.780541"
],
[
"-104.941406",
"36.809285"
],
[
"-103.798828",
"33.870416"
],
[
"-100.986328",
"34.089061"
],
[
"-100.283203",
"39.095963"
],
[
"-101.425781",
"45.336702"
],
[
"-106.435547",
"50.233152"
],
[
"-117.861328",
"50.233152"
],
[
"-123.75",
"46.55886"
],
[
"-124.013672",
"39.027719"
],
[
"-119.619141",
"33.578015"
]
]
}
},
{
"id": 23,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"22.851563",
"-13.068777"
],
[
"33.398438",
"-22.268764"
],
[
"36.386719",
"-2.811371"
],
[
"22.851563",
"-13.068777"
]
]
}
}
]
}
```
GET
Request
```
<SERVER_URL>/api/v1/feature/:id
Params
access_token: <access_token>
```
Response
```
{
"id": 18,
"type": "Feature",
"properties": {},
"geometry": {
"type": "Polygon",
"coordinates": [
[
"7.36084",
"50.666872"
],
[
"8.195801",
"49.823809"
],
[
"10.634766",
"50.190968"
],
[
"10.722656",
"51.481383"
],
[
"8.76709",
"51.522416"
],
[
"7.36084",
"50.666872"
]
]
}
}
```
Locations

Request
POST
```
<SERVER_URL>/api/v1/locations
Params
access_token: <access_token>
address: <address_string>	
```

Response
```
{id: <location_id>}
```
GET
Request
```
<SERVER_URL>/api/v1/locations/:id
Params:
access_token: <access_token>
```
Response
```
{
id: <location id>,
latitude: <latitude value>,
longitude: <longitude value>,
inside: <true or false>
}
```
