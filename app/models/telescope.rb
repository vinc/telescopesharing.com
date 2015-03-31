class Telescope
  include Mongoid::Document
  include Geocoder::Model::Mongoid

  field :name
  field :description

  field :aperture, type: Integer
  field :focal_length, type: Integer
  field :tube_type
  field :mount_type
  field :camera_type

  field :address
  field :coordinates, type: Array

  belongs_to :user
  has_many :messages
  has_many :reservations
  has_many :observations
  accepts_nested_attributes_for :observations, allow_destroy: true
  geocoded_by :address
  after_validation :geocode

  def available_observations
    self.observations.available_after(Date.today)
  end

  def focal_ratio
    focal_length.to_f / aperture unless focal_length.blank? || aperture.blank?
  end

  def angular_resolution
    116.0 / aperture unless aperture.blank?
  end
end
