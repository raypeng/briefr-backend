class StoriesController < ApplicationController

  include StoriesHelper
  
  def index
    @stories = Story.all.to_a
    @stories.map! { |s| expand_story s }
    @stories.each do |story|
      story.save
    end
    @stories
  end

  def new
    @story = Story.new
  end

  def create
    @story = Story.new(params[:story])
    
    @story.teller_realname = profile_name_of @story.teller_username
    @story.title = title_from_link @story.short_url
    @story.content = content_from_link @story.short_url
    @story.content_preview = preview_of @story.content

    @story.long_url = expand_url @story.short_url
    @story.count = count_occurrence_of_link @story.short_url
    # @story.time = # whoops! i dont know :(

    @story.save
  end
  
end
