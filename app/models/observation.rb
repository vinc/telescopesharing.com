class Observation
  include Mongoid::Document

  field :scheduled_on, type: Date
  field :reserved, type: Boolean, default: false

  has_many :reservations
  has_many :messages
  belongs_to :telescope

  def self.available
    where(reserved: false)
  end

  def self.available_on(date)
    available.where(scheduled_on: date)
  end

  def self.available_after(date)
    available.gt(scheduled_on: date)
  end

  def reservation # FIXME: Rename it active_reservation
    reservations.not.where(aasm_state: "canceled").first
  end

  def status
    if reserved?
      if scheduled_on < Date.today
        "done"
      else
        reservation.aasm_state
      end
    else
      if scheduled_on < Date.today
        "canceled"
      else
        "available"
      end
    end
  end
end
