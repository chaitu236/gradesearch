#!/bin/sh
#RAILS_ENV=production rake assets:precompile
RAILS_ENV=production bundle exec rake assets:precompile
#rvmsudo rails server -d -p 2000 -e production
rails server -d -p 2000 -e production
