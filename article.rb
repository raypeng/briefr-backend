require 'open-uri'
require 'readability'
require 'expander'
require 'url_expander' # might also work

$PREVIEW_LENGTH = 300

def domain(short_url)
  long_url = short_url.expand_urls
  puts long_url
  # long_url = UrlExpander::Client.expand(short_url)
  prefix, url = long_url.split("//")
  domain = url.split("/").first
  prefix + "//" + domain + "/"
end

def preview(html, url)
  content = html.split(" ").slice(0, $PREVIEW_LENGTH).join(" ")
  domain_url = domain url
  content + "...</p> <p>Readmore at <a href='#{url}'>#{domain_url}</a></p>"
end

url = "http://t.co/tOcfNQhUDn"
tags = %w[div p a pre b i strong]
attr = %w[href]
hash = { :tags => tags, :attributes => attr }
doc = Readability::Document.new(open(url).read, hash)
content = doc.content
puts doc.methods - Object.methods

puts doc.options
puts
puts content

