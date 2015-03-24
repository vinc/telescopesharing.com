class TelescopesController < ApplicationController
  expose(:telescopes) { Telescope.all }
  expose(:telescope, attributes: :telescope_params)

  def create
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
    telescope.destroy
  end

  # FIXME: needed only for JSON view
  # FIXME: Activemodel Serializer is not used by HTML view
  def show
    respond_with(telescope)
  end

  def index
    respond_with(telescopes)
  end

  private

  def telescope_params
    params.
      require(:telescope).
      permit(
        :name, :description,
        observations_attributes: [:id, :scheduled_at, :_destroy],
      )
  end
end
