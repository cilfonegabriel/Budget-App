# exit on error
 set -o errexit 

bundle install 
bundle exec rails assets: precompilar 
bundle exec rails assets: clean 
bundle exec rails db: migrar 

#si tiene semillas para ejecutar agregue: 
# bundle exec rails db:seed