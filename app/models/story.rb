class Story

  include StoriesHelper
  extend StoriesHelper
  
  include Mongoid::Document
  
  field :title,            type: String
  # field :content,          type: String
  field :content_preview,  type: String
  field :score,            type: Integer
  field :retweet,          type: Integer
  field :favorite,         type: Integer
  
  field :short_url,        type: String
  field :long_url,         type: String
  field :domain,           type: String
  field :tweet_id,         type: Integer
  field :teller_username,  type: String
  field :teller_realname,  type: String
  # field :time,             type: DateTime

  field :on_topic?,        type: Boolean, default: true
  
  # model relations
  belongs_to :category

  # validations
  validates_presence_of :short_url, :tweet_id, :teller_username, :category
  validates_uniqueness_of :short_url

  
  def self.update_stories_from_timeline
    
    stories = []
    @categories = Category.all
    @categories.each do |category|

      tellers = category.tellers
      tellers.each do |teller|

        $client.user_timeline(teller.username).take(1).each do |tweet|

          story = Story.new
          story.retweet = retweet_of tweet
          story.favorite = favorite_of tweet
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

  def prepare
    expand_story self
  end

end
n
