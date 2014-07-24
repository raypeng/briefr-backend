class Story

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
  
end
