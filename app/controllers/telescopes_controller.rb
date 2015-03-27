class TelescopesController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  expose(:telescopes) { Telescope.all } # FIXME: Activemodel Serializer
  expose(:telescope)
  expose(:reservation) { Reservation.new(telescope: telescope) }


  # FIXME: needed only for JSON view
  # FIXME: Activemodel Serializer is not used by HTML view
  def show
    respond_with(telescope)
  end

  def index
    respond_with(telescopes)
  end
end
