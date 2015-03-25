class ReservationsController < ApplicationController
  expose(:reservations)
  expose(:reservation, attributes: :reservation_params)
  expose(:telescope)

  def create
    if reservation.save
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
    if reservation.destroy
      redirect_to(telescope)
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:scheduled_at)
  end
end
