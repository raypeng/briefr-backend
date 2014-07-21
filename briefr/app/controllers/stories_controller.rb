class StoriesController < ApplicationController

  include StoriesHelper
  
  def index
<<<<<<< HEAD
=======

>>>>>>> inner-test-css
    @stories = Story.all
    @stories.map! { |s| expand_story s }
  end

end
