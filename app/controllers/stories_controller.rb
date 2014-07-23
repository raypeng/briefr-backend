class StoriesController < ApplicationController

  include StoriesHelper
  
  def index
    @stories = Story.where(on_topic?: true)
    @stories.map! { |s| expand_story s }
  end

end
