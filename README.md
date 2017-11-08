PresentAR
==========
The website component of a presentation aid for AR.

Continuous Deployment via Heroku
----
https://presentar.herokuapp.com/

Technologies used
----
- Ruby on Rails
- PostgreSQL

How to set up the application
----
```
$ git clone https://github.com/comatoastuk/presentAR.git
$ cd presentAR
$ bundle
$ rake db:setup
$ bin/rails db:migrate
$ rspec
$ bin/rails server
```
Tested using:
----
- RSpec
- Capybara

How to run tests
----
```sh
$ cd presentAR
$ rspec
```
