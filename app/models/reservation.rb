class Reservation
  include Mongoid::Document
  belongs_to :telescope
  field :scheduled_at, type: Date # FIXME: Duplicate with Observation
end
