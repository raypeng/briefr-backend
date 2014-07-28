class CategoriesController < ApplicationController

  @@NUM_STORIES_PER_CATEGORY_DISPLAY = 3

  def show

    @category = Category.find_by name: params[:name]
    @stories = @category.stories.where(on_topic?: true)
    # get stories newest on top
    @stories.sort_by! { |story| -story.token }
    @stories = @stories[0...@@NUM_STORIES_PER_CATEGORY_DISPLAY]

    render 'stories/index'
    
  end
  
end
