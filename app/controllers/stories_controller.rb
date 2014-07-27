class StoriesController < ApplicationController

  include StoriesHelper

  def index
    # Story.update_stories_from_timeline
    @stories = Story.where(on_topic?: true)
    # @stories.map! { |story| story.prepare }
    @stories.compact
  end

end
