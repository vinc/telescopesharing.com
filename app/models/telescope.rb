class Telescope
  include Mongoid::Document
  field :name
  field :description
  belongs_to :user
  embeds_many :observations
  accepts_nested_attributes_for :observations, allow_destroy: true
end
