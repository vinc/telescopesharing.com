class Telescope
  include Mongoid::Document
  field :name
  field :description
  belongs_to :user
  has_many :reservations
  has_many :observations
  accepts_nested_attributes_for :observations, allow_destroy: true

  def available_observations
    self.observations.where(reservation_id: nil).gt(scheduled_at: Date.today)
  end
end
