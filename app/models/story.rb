class Story

  require 'logger'
  
  include StoriesHelper
  extend StoriesHelper
  
  include Mongoid::Document
  
  field :title,            type: String
  field :content,          type: String
  field :content_preview,  type: String
  field :image,            type: String
  field :keywords,         type: String

  field :score,            type: Float
  field :shared,           type: Integer
  field :favorite_count,   type: Integer
  field :retweet_count,    type: Integer
  field :retweeters,       type: String
  
  field :short_url,        type: String
  field :long_url,         type: String
  field :domain,           type: String
  field :tweet_id,         type: Integer

  field :on_topic,         type: Boolean, default: true

  field :token,            type: Integer
  
  # class config vars
  @@NUM_STORIES_PER_TELLER_FETCH = 20
  @@NUM_STORIES_PER_CATEGORY_SAVE = 10

  # model relations
  belongs_to :category
  belongs_to :teller

  # validations
  validates_presence_of :short_url, :tweet_id, :teller, :category
  validates_uniqueness_of :short_url

  # add token before create
  before_create :assign_token

  
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
        
        $client.user_timeline(teller.username).take(@@NUM_STORIES_PER_TELLER_FETCH).each do |tweet|

          story = Story.new
          story.short_url = extract_url tweet.full_text

          # skip those without links
          if story.short_url.nil?
            next
          end
          
          story.retweet_count = retweet_of tweet
          story.favorite_count = favorite_of tweet
          story.tweet_id = tweet.id
          story.teller = teller
          story.category = category
          story.score = score_of story.retweet_count, story.favorite_count, story.teller.followers_count
          # story = expand_story story
          stories[category] << story
          
        end
      end
    end

    stories.keys.each do |category|
      stories[category].compact!
      stories[category] = stories[category].sort_by { |story| -story.score }
      count = 0
      stories[category].each do |story|

        if count >= @@NUM_STORIES_PER_CATEGORY_SAVE
          break
        end
        
        url_temp = story.short_url
        story = expand_story story

        begin
          if story.save
            count += 1
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
        rescue NoMethodError => e
          @@logger.error "#{url_temp} error in expanding story"
        rescue Exception => e
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
