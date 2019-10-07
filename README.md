
# Air freighter Cargo App.

Rails REST API fetching flight XML data from 3rd party flight data platform.
[FlightAware] (https://uk.flightaware.com/commercial/data/)

# Concept - 

Run an rails app to fetch cargo flight only data from a 3rd party api to enable Users(exporters/airfreight agents) to request
a quotation and make a booking for oversize cargo along with tracking of booked shipments.

This app was developed locally in AWS C9 enviroment with flight XML data API integration from a 3rd party.
[FlightAware] (https://uk.flightaware.com/commercial/data/)

# Prerequisites

ruby', '2.6.3'

rails', '4.2.8'

postgres 10.0

See Gem file for installed ruby gems

Devise for Authentication.


# 3rd party Vendor API Flight Data REQUIREMENTS:

Ruby 1.9 or above
FlightXML2 JSON REST Client for Ruby by auzroz: github
gem install FlightXML2RESTDriver
Save the following file as test.rb, but substitute your actual username and API key:

```
#!/usr/bin/env ruby

require './FlightXML2RESTDriver.rb'

require './FlightXML2Rest.rb'

username = 'YourUserName'

apiKey = 'YourAPIKey'

# This provides the basis for all future calls to the API
test = FlightXML2REST.new(username, apiKey)

# Enroute
print "Aircraft en route to KSMO:\n"
result = test.Enroute(EnrouteRequest.new('KSMO', 'ga', 15, 0 ))
pp result.enrouteResult
```

    
# Run following commands to view locally in dev enviroment.

### Configure your db login details in *'database.yml'* file.
AWS C9 set up

```bash

$ sudo su - postgres 

postgres=# create user "ec2-user" superuser;

$ psql -U ec2-user -W
```
```bash
$ rake db:create

rake db:migrate
```

Start the postresql server:
```
$ sudo service postgresql start

prior to starting the rails server - 

$ rails server -b $IP -p $PORT
```
Alternatively run locally - *localhost3000*
```bash
$ sudo /etc/init.d/postgresql restart

* Restarting PostgreSQL 10 database server                                                                      [ OK ]

$ rails s

=> Booting WEBrick
=> Rails 4.2.8 application starting in development on http://localhost:3000
```

## Images -

  



=======

