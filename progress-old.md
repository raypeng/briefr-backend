# Briefr

## Back-End Progress Update

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
require 'url_expander'
UrlExpander::Client.expand(short_url, :config_file =>
                           'config/url_expander_credentials.yml')
```

*   从link中抓取文章内容

```ruby
require 'open-uri'
require 'readability'

html = open('http://t.co/Xf8lOLjPwQ').read
content = Readability::Document.new(source).content
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
see "app/views/stories/index.html.erb"
```

*   rank links by popularity

```
TODO

## examine popularity by counting tweets containing the link
# url = "http://t.co/EsweORhs3G"
# puts client.search(url).count

this might not work since the same long_url might be represented by many short_urls...
and this is confirmed... gosh!
WHAT THE HELL are you thinking, TWITTER!!!

need other methods
```

*   remove duplicate articles

```
TODO

Can only ensure short_url field is unique
Can't prevent from different websites showing similar articles
Need extra mechanism
```

*   models and relationships

```
TODO

Category and Story for now
```

*   index page list view layout / skeleton

```
see "app/views/stories/index.html.erb"
```

*   add helper functions to fill fields of Story model

```
see "app/helpers/stories_helper.rb"
```

*   refactor database expansion logic

```
TODO

Now expanding the database entry is done at runtime, horribly slow!
Need method to enforce expansion at database insertion time!
```

*   need library to capture title from link

```ruby
require 'readability'
title = Readability::Document.new(source).title
```

*   need to update index page list view content (title, link to tweet)

```
see "app/views/stories/index.html.erb"
```

*   bit.ly config required by getting content and link expansion

```
added a pair of login and api-key for bitly in config file
```

*   trim extra syntax-irrelevant whitespace for story.content

```ruby
require 'html_press'
compressed_html = HtmlPress.press html
```

*   `story.content` by readability doesn't preserve format well for `<pre>` handling!

```
need at least <b><i><pre>... and <a href> working

Done by building my own wheel
```

*   `preview_of` might yield bad endings as of now

```
for example:
"biggest ...
as follows: ...

Done by using '</pre>' or '</p>' as natural endings
and specifying 'num_paragraph'
```

*   get in touch with Topsy API -- their service is perfect for our project!

```
seems their API service is closed...
some apikeys found on the internet are not working either.
```
