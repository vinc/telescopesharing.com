class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_ownership, except: [:new, :create]

  expose(:reservations)
  expose(:reservation, attributes: :reservation_params)
  expose(:telescope)

  def create
    observation = telescope.observations.
      where(scheduled_at: reservation.scheduled_at, reservation_id: nil).first

    reservation.user = current_user
    reservation.telescope = telescope
    reservation.observation = observation

    if reservation.save && observation.save
      redirect_to([telescope, reservation])
    else
      render :new
    end
  end

  def update
    if reservation.save
      redirect_to([telescope, reservation])
    else
      render :edit
    end
  end

  def destroy
    # FIXME: Remove reservation from observation automatically
    if reservation.observation.update(reservation: nil) && reservation.destroy
      redirect_to(telescope)
    end
  end

  private

  def require_ownership
    unless reservation.user == current_user
      flash[:error] = "Sorry, you cannot perform this operation."
      redirect_to(root_path)
    end
  end

  def reservation_params
    params.require(:reservation).permit(:scheduled_at)
  end
end
