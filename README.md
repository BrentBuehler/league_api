# README
To setup, navigate to directory, set up database, and start server:

`cd app`

`bundle install`

`rake db:create`

`rake db:migrate`

`rails server`

Now you can use curl or an app like Postman to make requests! Example:

Post to http://localhost:3000/leagues to create a league like this:
```
curl -v \
-H "Accept: application/json" \
-H "Content-type: application/json" \
-X GET \
-d ' {"league":{"name":"Big League Chew","cost":"5","lat_long":"40.339784,-75.946658"}}' \
http://localhost:3000/leagues
```
Get nearby leagues within budget to http://localhost:3000/leagues/nearby like this:
```
curl -X GET -d 'lat_long=39.952697,-75.166892&budget=11' http://localhost:3000/leagues/nearby
```