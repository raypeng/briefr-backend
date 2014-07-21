module StoriesHelper

  require_relative '../../config/twitter_config'
  
  require 'readability'
  require 'open-uri'
  require 'url_expander'
  require 'html_press'

  # 4 steps to get content
  # 1) replcae <pre>xxx</pre> by DUMMY-STRING
  # 2) process html with Readability
  # 3) replace /posts/1 with domain_name/posts/1 in <a href>
  # 4) replace DUMMY-STRING by <pre>xxx</pre>
  def content_from_link(url)
    
    def extract_pre_from(html)
      regex = /<pre.*?>.*?<\/pre>/m
      pre_list = html.scan regex
      html.gsub!(regex, 'DUMMY-STRING')
      [pre_list, html]
    end

    def add_domain(html, domain)
      html.gsub(/href=\"(\/.*?\")/, "href=\"#{domain}\\1")
    end

    def add_pre(html, pre_list)
      pre_list.each do |p|
        html.sub!('DUMMY-STRING', p)
      end
      html
    end
    
    html = open(url).read
    pre_list, replaced = extract_pre_from html
    hash = { :tags => %w[div p a b i pre h1 h2 h3 h4 h5 h6], :attributes => %w[href] }
    html = HtmlPress.press Readability::Document.new(replaced, hash).content
    domain = domain_of url
    add_pre(add_domain(html, domain), pre_list)
    
  end

  def title_from_link(url)
    Readability::Document.new(open(url).read).title
  end

  def profile_name_of(username)
    $client.user(username).name
  end

  def preview_of(content, num_paragraph = 5)
    # use </pre> </p> as natural ending
    # two extra <div><div> in the beginning
    content = content[10, content.length - 10]
    # make up <p> to enclose the region
    # if content[0, 2] != "<p"
    #   content = "<p>" + content
    # end
    offset = 0
    num_paragraph.times.each do
      offset = content.index(/<pre|<p/, offset) + 1
    end
    content.slice(0, offset - 1) + " <p>...</p>"
  end

  def expand_url(short_url)
    UrlExpander::Client.expand(short_url, :config_file =>
                               'config/url_expander_credentials.yml')
  end

  def count_occurrence_of_link(url)
    $client.search(url).count
    # might be slow
  end

  def domain_of(url)
    head, tail = url.split("//")
    domain_name = tail.split("/").first
    head + "//" + domain_name
  end

  def expand_story(story)

    story.teller_realname ||= profile_name_of story.teller_username
    story.long_url ||= expand_url story.short_url
    
    story.title ||= title_from_link story.long_url
    story.content ||= content_from_link story.long_url
    story.content_preview = preview_of story.content

    # this is not expected to work
    story.count ||= count_occurrence_of_link story.short_url

    story.save
    
    story

  end
  
end
