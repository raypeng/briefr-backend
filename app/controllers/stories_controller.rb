class StoriesController < ApplicationController

  include StoriesHelper

  def index
    
    # Story.update_stories_from_timeline
    @stories = Story.where(on_topic?: true)
    # @stories.map! { |story| story.prepare }
    # @stories.compact
    @stories = @stories.sort_by { |story| -story.score }

    $logger.info "stories#index count: #{@stories.count}"
    
  end

  def show
    
    @stories = Story.where token: params[:token]

    $logger.info "stories#show #{params[:token]}"
    
    render 'stories/index'
    
  end
    
end
