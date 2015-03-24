class ObservationSerializer < ActiveModel::Serializer
  attributes :id, :scheduled_at

  def id
    object.id.to_s
  end
end
