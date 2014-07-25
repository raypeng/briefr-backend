class StoriesController < ApplicationController

  include StoriesHelper
  
  def index
    update
    @stories = Story.where(on_topic?: true)
    @stories.map! { |s| expand_story s }
    @stories.compact!
  end

  def update
    stories = []
    @categories = Category.all
    @categories.each do |category|
      
      p category.name
      tellers = category.tellers
      tellers.each do |teller|
        
        p teller.username
        $client.user_timeline(teller.username).take(3).each do |tweet|
          
          p tweet.id
          retweet = retweet_of tweet
          favorite = favorite_of tweet
          story = Story.new
          story.short_url = extract_url tweet.full_text
          
          # skip those without links
          if story.short_url.nil?
            next
          end
          story.tweet_id = tweet.id
          story.teller_username = teller.username
          story.category = category
          story = expand_story story
          stories << story
          
        end
        
      end
      
    end
    
    stories.compact.each do |story|
      story.save
    end
    
  end
        
end
