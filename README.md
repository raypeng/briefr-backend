# Briefr

### Note to Sherry

```
You can now try to run the server and see how stupid it is!
Feel free to add anything to it, preferably getting the css working!
```

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
see "app/views/stories/index.html.erb"
```

*   rank links by popularity

```ruby
# examine popularity by counting tweets containing the link
url = "http://t.co/EsweORhs3G"
puts client.search(url).count

# this might not work since the same long_url might be represented by many short_urls...
# WHAT THE HELL are you thinking, TWITTER!!!
```

*   remove duplicate articles

```
Can only ensure short_url field is unique
Can't prevent from different websites showing similar articles
Need extra mechanism
```

*   models and relationships

```
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
Need method to enforce expansionat database insertion time!
It is too late today... Got to sleep!
```

*   readability doesn't get title entry

```
TODO
Might migrate to 'pismo' if that really helps
```
