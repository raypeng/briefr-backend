class Category
  include Mongoid::Document
  
  field :name, type: String

  has_many :stories

  validates_uniqueness_of :name

end
