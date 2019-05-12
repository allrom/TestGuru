#For changing the command used to launch web process on heroku
#
##web: bundle exec puma -t 5:5 -p ${port:-3000} -e ${RACK_ENV:-development}

web: bundle exec puma -C config/puma.rb
