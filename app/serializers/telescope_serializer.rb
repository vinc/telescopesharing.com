class TelescopeSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  
  has_many :observations

  def id
    object.id.to_s
  end

  def observations
    object.observations.gt(scheduled_at: Date.today)
  end
end
