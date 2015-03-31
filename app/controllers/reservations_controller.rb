class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user, only: [:edit, :update, :destroy]
  before_action :require_operator, only: [:accept, :decline]

  expose(:reservations)
  expose(:reservation)
  expose(:telescope)

  def create
    reservation.attributes = reservation_params

    # TODO: Use find_and_modify for atomicity
    observations = telescope.observations
    observation = observations.available_on(reservation.scheduled_on).first

    reservation.user = current_user
    reservation.telescope = telescope
    reservation.observation = observation

    if reservation.save && observation.update(reserved: true)
      redirect_to([telescope, reservation])
    else
      render :new
    end
  end

  def update
    reservation.attributes = reservation_params
    if reservation.save
      redirect_to([telescope, reservation])
    else
      render :edit
    end
  end

  def destroy
    if reservation.observation.update(reserved: false) && reservation.destroy
      redirect_to(telescope)
    end
  end

  def accept
    reservation.accept
    if reservation.save
      redirect_to(:back)
    end
  end

  def decline
    reservation.decline
    if reservation.save
      redirect_to(:back)
    end
  end

  private

  def require_user
    unless reservation.user == current_user
      flash[:error] = "Sorry, you cannot perform this operation."
      redirect_to(root_path)
    end
  end

  def require_operator
    unless reservation.telescope.user == current_user
      flash[:error] = "Sorry, you cannot perform this operation."
      redirect_to(root_path)
    end
  end

  def reservation_params
    params.require(:reservation).permit(:scheduled_on)
  end
end
