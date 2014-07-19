class Story
  include Mongoid::Document

  field :title,            type: String
  field :content,          type: String
  field :content_preview,  type: String
  field :score,            type: Integer, default: 1
  field :count,            type: Integer, default: 1
  
  field :short_url,        type: String
  field :long_url,         type: String
  field :tweet_id,         type: Integer
  field :teller_username,  type: String
  field :teller_realname,  type: String
  field :time,             type: DateTime

  # flag for dynamic expansion
  # field :expanded,         type: Boolean, default: false
  
  # timestamps! # wrong syntax maybe

  # model relations
  belongs_to :category

  # validations
  validates_presence_of :short_url, :tweet_id, :teller_username, :category
  
end
