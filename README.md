# Briefr

## Back-End TODO List

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

*   expand shortened links to get regular links

```ruby
# gem install expander
require 'expander'
long_url = short_url.expand_urls
```

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

*   产生缩略显示的部分段落

```ruby
def preview(html, url)
  content = html.split(" ").slice(0, $PREVIEW_LENGTH).join(" ")
  domain_url = domain url
  content + "...</p> <p>Readmore at <a href='#{url}'>#{domain_url}</a></p>"
end
```

*   显示文章内容缩略

```
TODO
```

*   rank links by popularity

```ruby
# examine popularity by counting tweets containing the link
url = "http://t.co/EsweORhs3G"
puts client.search(url).count
```

*   remove duplicate articles

```
TODO
```

*   models and relationships

```
TODO
```

*   index page list view layout

```
TODO
```
