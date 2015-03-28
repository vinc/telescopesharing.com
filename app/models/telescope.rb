class Telescope
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :name
  field :description

  field :tube_type
  field :aperture, type: Integer
  field :focal_length, type: Integer
  field :mount_type

  field :address
  field :coordinates, type: Array

  belongs_to :user
  has_many :reservations
  has_many :observations
  accepts_nested_attributes_for :observations, allow_destroy: true
  geocoded_by :address
  after_validation :geocode

  def available_observations
    self.observations.where(reservation_id: nil).gt(scheduled_at: Date.today)
  end

  def focal_ratio
    Float(focal_length) / aperture
  end
end
