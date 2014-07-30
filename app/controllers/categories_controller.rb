class CategoriesController < ApplicationController

  @@NUM_STORIES_PER_CATEGORY_DISPLAY = 3

  def show

    @category = Category.find_by name: params[:name]
    @stories = @category.stories.where(on_topic: true)

    # get stories highest score on top
    @stories = @stories.sort_by { |story| -story.score }
    @stories = @stories[0...@@NUM_STORIES_PER_CATEGORY_DISPLAY]
    # @stories = @stories.sort_by { |story| -story.token }

    $logger.info "categories#show #{params[:name]}"
    
    render 'stories/index'
    
  end
  
end
