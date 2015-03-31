class Message
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content

  belongs_to :user
  belongs_to :telescope
  belongs_to :reservation
  belongs_to :observation
end
