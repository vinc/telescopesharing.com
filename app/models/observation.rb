class Observation
  include Mongoid::Document
  field :scheduled_at, type: Date
  belongs_to :telescope
  belongs_to :reservation

  def status
    if reservation.nil?
      if scheduled_at < Date.today
        "cancelled"
      else
        "available"
      end
    else
      if scheduled_at < Date.today
        if reservation.accepted?
          "done"
        else
          "cancelled"
        end
      else
        if reservation.accepted?
          "reserved"
        else
          "pending"
        end
      end
    end
  end
end
