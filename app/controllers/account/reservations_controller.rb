class Account::ReservationsController < ApplicationController
  before_action :authenticate_user!

  expose(:reservations) { Reservation.where(user: current_user) }
end
