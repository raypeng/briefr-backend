ActiveAdmin.register Category do


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

  permit_params :name

  index do
    selectable_column
    column :name
    actions
    actions defaults: false do |category|
      link_to "Original", "/categories/#{category.name}"
    end
  end

  show do |category|
    attributes_table do
      row :name
      category.tellers.each do |teller|
        row :teller do
          teller.username
        end
      end
    end
  end
  
end
