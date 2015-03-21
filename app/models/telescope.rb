class Telescope
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  belongs_to :user
  embeds_many :slots
  accepts_nested_attributes_for :slots, allow_destroy: true
end
