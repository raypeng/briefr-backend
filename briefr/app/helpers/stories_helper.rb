module StoriesHelper

  require_relative '../../config/twitter_config'
  
  require 'readability'
  require 'open-uri'
  require 'expander'

  def profile_name_of(username)
    $client.user(username).name
  end

  def title_from_link(url)
    "some title"
  end

  def content_from_link(url)
    Readability::Document.new(open(url).read).content
    # need to trim extra whitespaces
  end

  def preview_of(content, length = 300)
    content.split(" ").slice(0, length).join(" ") + "...</p>"
    # might be broken somehow deja vu
  end

  def expand_url(short_url)
    short_url.expand_urls
  end

  def count_occurrence_of_link(url)
    $client.search(url).count
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
    if not story.expanded
      
      story.teller_realname = profile_name_of story.teller_username
      story.title = title_from_link story.short_url
      story.content = content_from_link story.short_url
      story.content_preview = preview_of story.content
      
      story.long_url = expand_url story.short_url
      story.count = count_occurrence_of_link story.short_url
      # story.time = # whoops! i dont know :(

      story.expanded = true
      
      story
    else
      story
    end
  end
  
end

