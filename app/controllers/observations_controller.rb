class ObservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_ownership, except: [:new, :create]

  expose(:observations)
  expose(:observation, attributes: :observation_params)
  expose(:telescope)

  def create
    observation.telescope = telescope

    if observation.save && observation.save
      redirect_to([telescope, observation])
    else
      render :new
    end
  end

  def update
    if observation.save
      redirect_to([telescope, observation])
    else
      render :edit
    end
  end

  def destroy
    # FIXME: Remove reservation for observation automatically
    if observation.reservation.destroy && observation.destroy
      redirect_to(telescope)
    end
  end

  private

  def require_ownership
    unless observation.telescope.user == current_user
      flash[:error] = "Sorry, you cannot perform this operation."
      redirect_to(root_path)
    end
  end

  def observation_params
    params.require(:observation).permit(:scheduled_on)
  end
end
