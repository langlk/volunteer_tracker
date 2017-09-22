# Volunteer Tracker

#### _Epicodus Project in Ruby, September 22, 2017_

#### By Kelsey Langlois

## Description

_A Ruby Web App for tracking the volunteers assigned to various nonprofit projects. Allows user to create, edit, and delete projects, and create and assign volunteers to them._

## Setup/Installation Requirements

* Clone this repository
* Ensure you have Postgres installed and running ([instructions here](https://www.learnhowtoprogram.com/ruby/ruby-database-basics/installing-postgres-7fb0cff7-a0f5-4b61-a0db-8a928b9f67ef))
* Create a database ```volunteer_tracker``` by running the command ```createdb -T template0 volunteer_tracker```
* Run the command ```psql volunteer_tracker < my_database.sql``` in the project root directory
* Run the command ```ruby app.rb``` in the project root directory
* Open ```localhost:4567``` in your web browser

## Specifications

* Projects have a title and a unique id, and can be saved, viewed, updated, and deleted.
* Volunteers have a name, project id, and unique id, and can be saved, viewed, updated, and deleted.
* Search function for Projects and Volunteers finds all entries of that type where title (name for Volunteers) contains search term.

## Support and contact details

_Please contact [kels.langlois@gmail.com](mailto:kels.langlois@gmail.com) with questions, comments, or issues._

## Technologies Used

* Ruby
* Sinatra
* Postgres

### License

Copyright (c) 2017 **Kelsey Langlois**

*This software is licensed under the MIT license.*
