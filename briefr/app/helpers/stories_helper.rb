module StoriesHelper

  require_relative '../../config/twitter_config'
  
  require 'readability'
  require 'open-uri'
  require 'expander'
  require 'pismo'

  def profile_name_of(username)
    $client.user(username).name
  end

  def content_from_link(url)
    Readability::Document.new(open(url).read).content
    # need to trim extra whitespaces
  end

  def title_from_link(url)
    Pismo[url].html_title
  end

  def preview_of(content, length = 1000)
    content.split(" ").slice(0, length).join(" ") + "...</p>"
    # might be broken somehow deja vu
  end

  def expand_url(short_url)
    short_url.expand_urls
  end

  def count_occurrence_of_link(url)
    c = $client.search(url).count
    puts "count: #{c}"
    c
    # might be slow
  end

  def domain_of(url)
    url = expand_url url
    head, tail = url.split("//")
    domain_name = tail.split("/").first
    # need to accumulate a mapping forb.es -> forbes.com
    head + "//" + domain_name + "/"
  end

  def expand_story(story)

    story.teller_realname ||= profile_name_of story.teller_username
    story.title ||= title_from_link story.short_url
    story.content ||= content_from_link story.short_url
    story.content_preview = preview_of story.content
      
    story.long_url ||= expand_url story.short_url
    story.count = count_occurrence_of_link story.short_url
    # story.time = # whoops! i dont know :(

    story.save
    
    story

  end
  
end

