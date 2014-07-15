# Briefr

## Back-End

#### _确认可行性_

1.  已知要follow的twitter帐号,能否拿到他的tweets(through twitter api)

```ruby
# access user timeline of tweets
timeline = client.user_timeline("kaifulee")
lsmethods timeline
# get a number of tweets from timeline
tweet = timeline.take(5).first
puts tweet.full_text
```

2.  从所有tweets中,collect有external link的

```ruby
URI.extract(s)
```

3.  expand shortened links to get regular links

4.  从link中抓取文章内容

5.  显示文章内容缩略

6.  remove deuplicate articles

