class CategoriesController < ApplicationController

  def show

    @category = Category.find_by name: params[:name]
    @stories = @category.stories.where(on_topic?: true)

    render 'stories/index'
    
  end
  
end
