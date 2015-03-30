class Observation
  include Mongoid::Document

  field :scheduled_on, type: Date

  belongs_to :telescope
  belongs_to :reservation

  def status
    if reservation.nil?
      if scheduled_on < Date.today
        "canceled"
      else
        "available"
      end
    else
      if scheduled_on < Date.today
        if reservation.accepted?
          "done"
        else
          "canceled"
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
