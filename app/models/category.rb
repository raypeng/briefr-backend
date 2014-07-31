class Category

  include Mongoid::Document
  
  field :name,             type: String

  # model relations
  has_many :stories
  has_many :tellers

  # validations
  validates_presence_of :name
  validates_uniqueness_of :name

end
