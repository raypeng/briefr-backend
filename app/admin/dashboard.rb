ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    panel "How to use the admin panel" do
      "This page only serves as an overview of contents! To edit story, go to Stories session - click the Stories tab above."
    end
    
    columns do

      column do
        panel "Tech (released)" do
          ul do
            stories = Category.find_by(name: "tech").stories
            stories = stories.select! { |s| s.on_topic == true }
            stories.each do  |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

      column do
        panel "Business (released)" do
          ul do
            stories = Category.find_by(name: "biz").stories
            stories = stories.select! { |s| s.on_topic == true }
            stories.each do  |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

      column do
        panel "Lifestyle (released)" do
          ul do
            stories = Category.find_by(name: "lifestyle").stories
            stories = stories.select! { |s| s.on_topic == true }
            stories.each do  |story|
              li link_to story.title, admin_story_path(story)
            end
          end
        end
      end

    end
    
  end
  
end
