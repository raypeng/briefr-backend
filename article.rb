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

def save(html)
  header = "<meta charset='utf-8'>"
  File.write("sample.html", header + html)
end

url = 'http://t.co/Xf8lOLjPwQ'
temp = Readability::Document.new(open(url).read)
html = Readability::Document.new(open(url).read).content
puts temp.methods - Object.methods
# puts preview(html, url)
# save preview(html, url)

puts domain 'http://t.co/wqeZGMYn1n'

link = "http://t.co/ZGEGdas"
puts link.expand_urls
puts UrlExpander::Client.expand("http://t.co/ZGEGdas", :nested_shortening => true,
                                :config_file => 'briefr/config/url_expander_credentials.yml')
