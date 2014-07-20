require 'topsy'

# grab your API key from http://manage.topsy.com/app/
Topsy.configure do |config|
  # both yield invalid user unauthorized error
  # config.api_key = "38A260E9D12A4908B1AF9184B691131"
  # config.api_key = "FAF7F2D0D8A143978CB7762CE35FCF99"
end

Topsy.rate_limit

Topsy.author_info('http://twitter.com/barackobama')

Topsy.experts('programming')

Topsy.experts('programming', :perpage => 2, :page => 1)

Topsy.link_posts('http://twitter.com/barackobama', :perpage => 2, :page => 2)

Topsy.link_posts('http://twitter.com/barackobama')

Topsy.link_post_count('http://twitter.com/barackobama')

Topsy.url_info('http://etagwerker.com')

Topsy.stats('http://www.google.com')

Topsy.search('rock')

Topsy.search('rock', :perpage => 2, :page => 3)

Topsy.search('rock', :perpage => 2, :page => 3, :window => 'd')

Topsy.search_count('rock')

Topsy.related('http://www.twitter.com')

Topsy.tags('http://twitter.com')

Topsy.trending

Topsy.trending(:page => 3, :perpage => 2)

Topsy.trackbacks('http://twitter.com', :perpage => 2, :page => 2)

Topsy.trackbacks('http://twitter.com', :perpage => 2, :page => 2, :contains => 'mashable')

# Fetch search results for the query "gemcutter"
results = Topsy.search("gemcutter")

# Fetch search counts for the query "gemcutter"
counts = Topsy.search_count("gemcutter")

# TOPSY doesn't seem to work at all!
