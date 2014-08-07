RAILS_ENV=production rake db:mongoid:drop
RAILS_ENV=production rake db:seed
whenever -w
crontab -l
