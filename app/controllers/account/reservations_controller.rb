class Account::ReservationsController < ApplicationController
  before_action :authenticate_user!

  expose(:reservations) do
    Reservation.where(user: current_user).desc(:scheduled_on)
  end
end
