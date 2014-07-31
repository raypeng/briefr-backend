class Teller

  include Mongoid::Document

  field :username,         type: String
  field :description,      type: String

  # model relations
  belongs_to :category

  # validations
  validates_presence_of :username, :category
  validates_uniqueness_of :username

  # add descriptions before create
  before_create :assign_description

  private

  def assign_description
    self.description = $client.user(username).description
  end

end
