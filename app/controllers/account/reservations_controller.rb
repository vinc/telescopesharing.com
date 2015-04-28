class Account::ReservationsController < ApplicationController
  before_action :authenticate_user!

  expose(:reservations) do
    current_user.reservations.desc(:scheduled_on)
  end
end
