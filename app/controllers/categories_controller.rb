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
    # get x recent stories and sort by score descending
    @stories = @stories.sort_by { |story| -story.token}
    @stories = @stories[0...@@NUM_STORIES_PER_CATEGORY_DISPLAY]
    @stories = @stories.sort_by { |story| -story.score }

    $logger.info "categories#show #{params[:name]}"
    render 'categories/index'
  end
  
end
