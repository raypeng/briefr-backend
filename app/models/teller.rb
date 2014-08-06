class Teller

  include Mongoid::Document

  field :username,         type: String
  field :description,      type: String
  field :followers_count,  type: Integer

  # model relations
  belongs_to :category

  # validations
  validates_presence_of :username, :category
  validates_uniqueness_of :username

  # add descriptions before create
  before_create :assign_properties

  private

  def assign_properties
    u = $client.user(username)
    d = u.description
    if d.nil?
      self.description = ""
    else
      self.description = d
    end
    self.followers_count = u.followers_count
  end

end
