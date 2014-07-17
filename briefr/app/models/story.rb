class Story
  include MongoMapper::Document

  key :title            String
  key :content          String
  key :content_preview  String
  key :score            Integer, :default => 1
  key :count            Integer, :default => 1
  
  key :short_url        String
  key :long_url         String
  key :tweet_id         Integer
  key :teller_username  String
  key :teller_realname  String
  key :time             DateTime
  
  timestamps!

  # model relations
  belongs_to :Category

  # validations
  validates_presence_of :short_url, :tweet_id, :teller_username
  
end
