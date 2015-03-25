class Observation
  include Mongoid::Document
  field :scheduled_at, type: Date
  belongs_to :telescope
  belongs_to :reservation
end
