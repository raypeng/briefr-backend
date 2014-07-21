class Category

  include Mongoid::Document
  
  field :name, type: String

  # model relations
  has_many :stories

  # validations
  validates_uniqueness_of :name

end
