class Slot
  include Mongoid::Document
  field :scheduled_at, type: Time
end
