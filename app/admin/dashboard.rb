ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    panel "How to use the admin panel" do
      "This page only serves as an overview of contents! To edit story, go to Stories session - click the Stories tab above."
    end
    
    columns do

      column do
        panel "Tech" do
          ul do
            Category.find_by(name: "tech").stories.each do |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

      column do
        panel "Business" do
          ul do
            Category.find_by(name: "biz").stories.each do |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

      column do
        panel "Lifestyle" do
          ul do
            Category.find_by(name: "lifestyle").stories.each do |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

    end
    
  end
  
end
