class Reservation
  include Mongoid::Document
  field :scheduled_at, type: Date # FIXME: Duplicate with observation
  has_one :observation
  belongs_to :telescope
  validates_presence_of :observation
  validates_presence_of :telescope
end
