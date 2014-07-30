class StoriesController < ApplicationController

  include StoriesHelper

  def index
    # Story.update_stories_from_timeline
    @stories = Story.where(on_topic: true)
    # @stories.map! { |story| story.prepare }
    # @stories.compact
    @stories = @stories.sort_by { |story| -story.score }
    $logger.info "stories#index count: #{@stories.count}"
  end

  def show
    @stories = Story.where token: params[:id]
    $logger.info "stories#show #{params[:id]}"
    render 'stories/index'
  end

  def edit
    @story = Story.find params[:id]
    $logger.info "stories#edit #{params[:id]}"
  end

  def update
    @story = Story.find params[:id]
    p = story_params
    p[:content] = sanitize p[:content]
    p[:content_preview] = sanitize p[:content_preview]
    @story.update(p)
    $logger.info "stories#edit #{params[:id]}"
    if p[:on_topic] == false
      $logger.info "marked off-topic by hand: #{params[:id]}"
    end
    redirect_to '/'
  end

  private

  def story_params
    params.require(:story).permit(:title, :content, :content_preview, :on_topic)
  end
    
end
