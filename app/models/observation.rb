class Observation
  include Mongoid::Document
  field :scheduled_at, type: Date
  embedded_in :telescope
end
