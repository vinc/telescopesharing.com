class Reservation
  include Mongoid::Document
  include AASM

  field :aasm_state
  field :scheduled_on, type: Date # FIXME: Duplicate with observation

  belongs_to :observation
  belongs_to :telescope
  belongs_to :user

  validates_presence_of :observation
  validates_presence_of :telescope
  validates_presence_of :user

  aasm do
    state :pending, initial: true
    state :accepted
    state :declined
    state :canceled

    event :accept do
      transitions from: :pending, to: :accepted
    end

    event :decline do
      transitions from: :pending, to: :declined
    end

    event :cancel do
      transitions from: :accepted, to: :canceled
    end
  end
end
