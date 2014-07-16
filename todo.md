# Briefr

## Back-End

#### _确认可行性_

*   已知要follow的twitter帐号,能否拿到他的tweets(through twitter api)

```ruby
# access user timeline of tweets
timeline = client.user_timeline("kaifulee")

# get a number of tweets from timeline
tweet = timeline.take(5).first
puts tweet.full_text
```

*   从所有tweets中,collect有external link的

```ruby
# extract url substring from tweet content string s
URI.extract(s)
```

*   ~~expand shortened links to get regular links~~

*   从link中抓取文章内容

```ruby
require 'open-uri'
# gem install ruby-readability
require 'readability'

source = open('http://t.co/Xf8lOLjPwQ').read
content = Readability::Document.new(source).content
puts content

header = "<meta charset='utf-8'>"
File.write('sample.html', header + content)
```

*   显示文章内容缩略

*   remove deuplicate articles
