class Telescope
  include Mongoid::Document
  field :name
  field :description
  belongs_to :user
  embeds_many :observations
  has_many :reservations
  accepts_nested_attributes_for :observations, allow_destroy: true

  def upcomming_observations
    self.observations.gt(scheduled_at: Date.today)
  end
end
