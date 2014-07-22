class Teller

  include Mongoid::Document

  field :username,         type: String

  # model relations
  belongs_to :category

  # validations
  validates_presence_of :username, :category
  validates_uniqueness_of :username

end
