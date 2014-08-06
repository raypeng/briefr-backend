ActiveAdmin.register Teller do


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

  permit_params :category_id, :username, :description, :followers_count

  index do
    selectable_column
    column :category
    column :username
    column :description
    column :followers_count
    actions
  end

end
