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

  def edit
    @story = Story.find params[:id]
    $logger.info "stories#edit #{params[:id]}"
  end

  def update
    @story = Story.find params[:id]
    @story.update(story_params)
    $logger.info "stories#edit #{params[:id]}"
    redirect_to '/'
  end

  private

  def story_params
    params.require(:story).permit(:title, :content, :content_preview)
  end
    
end
