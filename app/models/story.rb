class Story

  require 'logger'
  
  include StoriesHelper
  extend StoriesHelper
  
  include Mongoid::Document
  
  field :title,            type: String
  field :content,          type: String
  field :content_preview,  type: String
  field :image,            type: String
  field :keywords,         type: Array

  field :score,            type: Integer
  field :shared,           type: Integer
  field :favorite,         type: Integer
  field :retweet,          type: Integer
  field :retweeters,       type: String
  
  field :short_url,        type: String
  field :long_url,         type: String
  field :domain,           type: String
  field :tweet_id,         type: Integer
  field :teller_username,  type: String
  field :teller_realname,  type: String

  field :on_topic,         type: Boolean, default: true

  field :token,            type: Integer
  
  # class config vars
  @@NUM_STORIES_PER_CATEGORY_FETCH = 50
  @@NUM_STORIES_PER_CATEGORY_SAVE = 50

  # model relations
  belongs_to :category
  belongs_to :teller

  # validations
  validates_presence_of :short_url, :tweet_id, :teller_username, :category
  validates_uniqueness_of :short_url

  # add token before create
  before_create :assign_token, :assign_teller

  
  def self.update_stories_from_timeline

    @@logger = Logger.new(Rails.root.join('log', 'logger.log'))
    @@logger.sev_threshold = Logger::INFO
    @@logger.info "updating stories"
    
    stories = {}
    @categories = Category.all
    @categories.each do |category|

      @@logger.debug "category: #{category.name}"
      
      stories[category] = []
      tellers = category.tellers
      tellers.each do |teller|

        @@logger.debug "teller: #{teller.username}"
        
        $client.user_timeline(teller.username).take(@@NUM_STORIES_PER_CATEGORY_FETCH).each do |tweet|

          story = Story.new
          story.short_url = extract_url tweet.full_text

          # skip those without links
          if story.short_url.nil?
            next
          end
          
          story.retweet = retweet_of tweet
          story.favorite = favorite_of tweet
          story.tweet_id = tweet.id
          story.teller_username = teller.username
          story.category = category
          story.score = score_of story.retweet, story.favorite
          # story = expand_story story
          stories[category] << story
          
        end
      end
    end

    stories.keys.each do |category|
      stories[category].compact!
      stories[category] = stories[category].sort_by { |story| -story.score }
      stories[category][0...@@NUM_STORIES_PER_CATEGORY_SAVE].each do |story|
        story = expand_story story

        if not story.nil?
          begin
            if story.save
              @@logger.info "#{story.short_url} saved"
            else
              if story.errors.messages == { :short_url => ["is already taken"] }
                @@logger.info "#{story.short_url} already in db"
                raise DuplicateLinkError.new("#{story.short_url} already in db")
              else
                @@logger.error "#{story.short_url} can't be inserted"
                raise IOError.new("can't insert story #{story.short_url}")
              end
            end
          rescue Exception => e
          end
        end

      end
    end

    @@logger.close
    
  end

  def prepare
    expand_story self
  end

  private

  def assign_token
    self.token = Sequence.generate_id :story
  end

  def assign_teller
    self.teller = Teller.find_by :username, self.teller_username
  end
  
end

class Sequence
  
  include Mongoid::Document
  
  field :object
  field :last_id, type: Integer, default: 0

  def self.generate_id(object)
    seq = Sequence.find_or_create_by object: object
    seq.inc last_id: 1
    seq.last_id
  end
  
end
