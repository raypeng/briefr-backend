module StoriesHelper

  require_relative '../../config/twitter_config'

  require 'readability'
  require 'sanitize'
  require 'open-uri'
  require 'html_press'
  require 'cgi'
  require 'json'
  require 'httparty'

  IGNORED_DOMAINS = ['http://www.youtube.com',
                     'http://downloads.bbc.co.uk',
                     'http://instagram.com'
                    ]
  
  NUM_PARAGRAPH_PREVIEW_DEFAULT = 5
  NUM_CHARACTER_PREVIEW_THRESHOLD = 1000
  NUM_RETWEETERS_DISPLAY = 1

  @@logger = Logger.new(Rails.root.join('log', 'logger.log'))

  class DuplicateLinkError < Exception; end
  class LinkExpansionError < Exception; end
  
  # 4 steps to get content
  # 1) replcae <pre>xxx</pre> by DUMMY-STRING
  # 2) process html with Readability
  # 3) replace /posts/1 with domain_name/posts/1 in <a href>
  # 4) replace DUMMY-STRING by <pre>xxx</pre>
  def content_from(html, url)
    
    def extract_pre_from(html)
      regex = /<pre.*?>.*?<\/pre>/m
      pre_list = html.scan regex
      html.gsub! regex, 'DUMMY-STRING'
      [pre_list, html]
    end

    def add_domain(html, domain)
      html.gsub! /a href=\"(\/.*?\")/, "a href=\"#{domain}\\1"
      html.gsub! /img src=\"(\/.*?\")/, "img src=\"#{domain}\\1"
      html
    end

    def add_pre(html, pre_list)
      pre_list.each do |p|
        html.sub!('DUMMY-STRING', p)
      end
      html
    end
    
    pre_list, replaced = extract_pre_from html
    params = { :tags => %w[div span p a b i pre h1 h2 h3 h4 h5 h6 strong small em
                          blockquote ul ol li img],
               :attributes => %w[href src] }
    html = HtmlPress.press Readability::Document.new(replaced, params).content
    domain = domain_of url
    output = add_pre(add_domain(html, domain), pre_list)
    output = sanitize output
    output.gsub /<img /, "<img onError=\"this.style.display='none';\" "
    
  end

  def title_from_html(html)
    Readability::Document.new(html).title.gsub /\t/, ""
  end

  def keywords_of(html)
    ["keyword-1", "keyword-2"]
  end

  def profile_name_of(username)
    $client.user(username).name
  end

  def preview_of(content,
                 num_paragraph = NUM_PARAGRAPH_PREVIEW_DEFAULT,
                 num_character = NUM_CHARACTER_PREVIEW_THRESHOLD)
                 
    # two extra <div><div> in the beginning
    # content = content[10, content.length - 10]
    
    # use </pre> </p> as natural ending
    if content.length < num_character
      output = content + " <p>...</p>"
    else
      offset = 0
      while offset < num_character do
        temp = content.index(/<\/pre|<\/p/, offset)
        if temp.nil?
          offset = 1
          break
        end
        offset = temp + 1
      end
      output = content.slice(0, offset - 1) + " <p>...</p>"
    end
    output = sanitize output
    output.gsub /<img /, "<img onError=\"this.style.display='none';\""
  end

  def image_of(html)
    m = html.match /<img .*?>/
    if m.nil?
      # future: one predefined img for each category as placeholder
      ""
    else
      m[0]
    end
  end

  def expand_url(short_url)
    begin
      # UrlExpander::Client.expand(short_url, :config_file =>
      # 'config/url_expander_credentials.yml',
      #                            :limit => 50)
      
      # response = HTTParty.get("http://expandurl.appspot.com/expand?url=#{CGI.escape(short_url)}")
      # JSON.parse(response.body)['end_url']
      
      response = HTTParty.get("http://api.longurl.org/v2/expand?url=#{CGI.escape(short_url)}&format=json")
      long_url = JSON.parse(response.body)['long-url']
      if long_url.nil?
        raise LinkExpansionError.new("#{short_url} return nil from expanding API")
      else
        long_url
      end
    rescue LinkExpansionError => e
      @@logger.error e.message
      short_url
    rescue Exception => e
      @@logger.error "#{short_url} can't be fetched or expanded"
      short_url
    end
  end

  def count_occurrence_of_link(url)
    # might be slow
    $client.search(url).count
  end

  def retweet_of(tweet_obj)
    tweet_obj.retweet_count
  end

  def retweeters_of(tweet_obj)
    users = $client.retweeters_of tweet_obj, { :count => 100 }
    @@logger.debug "overall: #{users.length}"
    users = users.sort_by { |user| -user.followers_count }
    usernames = users.map { |user| user.screen_name }
    usernames = usernames[0...NUM_RETWEETERS_DISPLAY]
    if usernames.empty?
      ""
    else
      "@" + usernames.join(",@")
    end
  end
  
  def favorite_of(tweet_obj)
    tweet_obj.favorite_count
  end

  def score_of(retweet, favorite)
    retweet + favorite * 2
  end

  def shared_of(url, retweet)
    begin
      response = HTTParty.get("http://urls.api.twitter.com/1/urls/count.json?url=#{CGI.escape(url)}")
      count = JSON.parse(response.body)['count']
      if count.nil?
        raise CountSharedError.new("#{url} return nil from counting API")
      else
        count
      end
    rescue CountSharedError => e
      @@logger.error e.message
      retweet * 3
    rescue Exception => e
      @@logger.error "#{url} retweet can't be counted"
      retweet * 3
    end
  end

  def domain_of(url)
    head, tail = url.split("//")
    domain_name = tail.split("/").first
    head + "//" + domain_name
  end

  def extract_url(text)
    match = text.match(/http:\/\/t.co\/\S*/)
    if match.nil?
      nil
    else
      match[0]
    end
  end

  def sanitize(html)
    Sanitize.fragment(html, Sanitize::Config::RELAXED)
  end
  
  def expand_story(story)

    story.teller_realname ||= profile_name_of story.teller_username
    story.long_url ||= expand_url story.short_url
    story.domain ||= domain_of story.long_url

    # deal with sources dont want
    if IGNORED_DOMAINS.include? story.domain
      story.destroy
      return nil
    end

    begin

      html = open(story.short_url, :read_timeout => 5).read
      story.title ||= title_from_html html
      story.content ||= content_from html, story.long_url
      story.content_preview = preview_of story.content
      story.image ||= image_of story.content
      story.keywords ||= keywords_of story.content

      t = $client.status(story.tweet_id)
      story.retweet ||= retweet_of t
      story.favorite ||= favorite_of t
      story.retweeters ||= retweeters_of t
      story.score = score_of story.retweet, story.favorite
      story.shared ||= shared_of story.long_url, story.retweet
      
      return story
      
    rescue Exception => e
      # once encounter can't fetch the story, regard the story a bad one
      @@logger.error "in expand_story: #{e.message}"
      return nil
      
    end

  end
  
end
