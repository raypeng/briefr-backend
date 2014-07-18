require 'expander'
require 'pismo'

url = 'http://t.co/Xf8lOLjPwQ'
url = 'http://t.co/tOcfNQhUDn'
url = 'http://t.co/wqeZGMYn1n'
url = 'http://t.co/hk4L2VENS3'

doc = Pismo::Document.new(url)
puts doc.title
puts
puts doc.author
puts
puts doc.body
puts
puts doc.html_body
puts
puts doc.html_title
puts
puts doc.keywords

puts doc.methods - Object.methods

# seems doc.html_title works best for title
# and body doesn't work at all!

bitly_url = 'http://t.co/wqeZGMYn1n'
long_url = bitly_url.expand_urls

puts Pismo[long_url].title

# bit.ly needs special care
# redirection forbidden: http://bit.ly/1nTKHpx -> https://engineering.heroku.com/blogs/2014-07-17-sf-streaming-api (RuntimeError)

