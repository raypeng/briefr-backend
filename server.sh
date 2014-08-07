mkdir -p tmp/pids
sudo service nginx restart
unicorn -c config/unicorn.rb -D -E production
