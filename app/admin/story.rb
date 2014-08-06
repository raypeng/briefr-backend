ActiveAdmin.register Story do

  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  permit_params :title, :content, :content_preview, :keywords, :retweeters,
                :on_topic, :image, :tweet_text

  actions :all, :except => [:new]
  
  config.sort_order = "token_desc"
  
  # thanks to this man
  # https://github.com/gregbell/active_admin/issues/53

  index do
    panel "Reminder" do
      "To finish editing the story and publish, remember to mark 'on_topic' to 'true'."
    end
    selectable_column
    column :teller
    column :category
    column :title
    column :keywords
    column :on_topic
    actions defaults: true do |story|
      link_to "Original", "/stories/#{story.token}"
    end
  end

end
