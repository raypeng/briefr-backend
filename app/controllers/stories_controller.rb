class StoriesController < ApplicationController

  include StoriesHelper

  def show
    @story = Story.find_by token: params[:id]
    $logger.info "stories#show #{params[:id]}"
  end

  # def edit
  #   @story = Story.find params[:id]
  #   $logger.info "stories#edit #{params[:id]}"
  # end

  # def update
  #   @story = Story.find params[:id]
  #   p = story_params
  #   p[:content] = sanitize_with_img p[:content]
  #   p[:content_preview] = sanitize_without_img p[:content_preview]
  #   @story.update(p)
  #   $logger.info "stories#edit #{params[:id]}"
  #   if p[:on_topic] == false
  #     $logger.info "marked off-topic by hand: #{params[:id]}"
  #   end
  #   redirect_to '/'
  # end

  # private

  # def story_params
  #   params.require(:story).permit(:title, :content, :content_preview, :on_topic)
  # end
    
end
