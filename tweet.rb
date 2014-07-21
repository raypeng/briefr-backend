require_relative 'briefr/config/twitter_config'

client = $client

def lsmethods(obj)
  puts (obj.methods - Object.methods).join("   ")
end

def get_links(str)
  URI.extract(str)
end
  
def has_link?(t)
  get_links(t.full_text).any?
end

# find user by id and get his recent
u = client.user(213747670)
t = client.user(213747670).tweet
lsmethods u

# access user timeline of tweets
timeline = client.user_timeline("kaifulee")
lsmethods timeline
# get a number of tweets from timeline
tweet = timeline.take(5).first
puts tweet.full_text

# access content
puts t.full_text
puts t.full_text.is_a? String

# access tweet url
puts t.url

# access hashtags
puts t.hashtags?
puts t.hashtags

# access user mentions
um = t.user_mentions.first

# access links within tweet
puts get_links t.full_text

# testing with leekaifu status
w = client.status(425126368007827456)
puts w.full_text
# refer back to the user from tweet
puts w.user.tweets_count

puts get_links w.full_text


# customized search
client.search("#worldcupfinal #Germany win", :result_type => "mixed").take(1).collect do |tweet|
  puts "#{tweet.user.screen_name}: #{tweet.text}"
end

# examine popularity by counting tweets containing the link
url = "http://t.co/EsweORhs3G"
puts client.search(url).count
