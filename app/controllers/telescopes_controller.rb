class TelescopesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_ownership, only: [:edit, :delete]

  expose(:telescopes) { Telescope.all } # FIXME: Activemodel Serializer
  expose(:telescope, attributes: :telescope_params)
  expose(:reservation) { Reservation.new(telescope: telescope) }

  # FIXME: needed only for JSON view
  # FIXME: Activemodel Serializer is not used by HTML view
  def index
    respond_with(telescopes)
  end

  def show
    respond_with(telescope)
  end

  def create
    telescope.user = current_user
    if telescope.save
      redirect_to(telescope)
    else
      render :new
    end
  end

  def update
    if telescope.save
      redirect_to(telescope)
    else
      render :edit
    end
  end

  def destroy
    if telescope.destroy
      redirect_to(account_telescopes_path)
    end
  end

  private

  def require_ownership
    unless telescope.user == current_user
      flash[:error] = "You must be the telescope owner to perform this operation."
      redirect_to(account_telescopes_path)
    end
  end

  def telescope_params
    params.
      require(:telescope).
      permit(
        :name, :address, :description,
        :aperture, :focal_length, :tube_type, :mount_type, :camera_type,
        observations_attributes: [:id, :scheduled_at, :_destroy],
      )
  end
end
