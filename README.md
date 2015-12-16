Bolognesa, by Ombu Labs
=========

Available at [http://bolognesa.ombulabs.com](http://bolognesa.ombulabs.com)

Bolognesa is a [Pomodoro technique](http://www.pomodorotechnique.com)<sup>®</sup> online time tracker.

Setup
-----

To install Bolognesa in a development environment, you can follow the next steps:

### Ruby

    rvm install '2.1.0'

### First-time only

Clone the repo

    git clone git@github.com:ombulabs/bolognesa.git

Go to the project path

    cd path/to/bolognesa

Copy the YML database config

    cp config/database.yml.sample config/database.yml

Set up the database

    bundle exec rake db:migrate

Install dependencies

    bundle install

Start
-----

    rvm use 2.1.0-p0@bolo
    bundle exec rvmsudo rails server

Copyright
---------

Copyright (c) 2015 [Ombu Labs](http://ombulabs.com)
