class StoriesController < ApplicationController

  include StoriesHelper
  
  def index

    @stories = Story.all
    @stories.map! { |s| expand_story s }
  end

end
