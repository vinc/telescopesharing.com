class ObservationSerializer < ActiveModel::Serializer
  attributes :id, :scheduled_on

  def id
    object.id.to_s
  end
end
