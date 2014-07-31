class CategoriesController < ApplicationController

  @@NUM_STORIES_PER_CATEGORY_DISPLAY = 10

  def index
    @stories = Story.where(on_topic: true)
    @stories = @stories.sort_by { |story| -story.score }
    $logger.info "categories#index count: #{@stories.count}"
  end
  
  def show
    @category = Category.find_by name: params[:name]
    @stories = @category.stories.where(on_topic: true)
    # get stories highest score on top
    @stories = @stories.sort_by { |story| -story.score }
    @stories = @stories[0...@@NUM_STORIES_PER_CATEGORY_DISPLAY]

    $logger.info "categories#show #{params[:name]}"
    render 'categories/index'
  end
  
end
