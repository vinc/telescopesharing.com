class Account::ObservationsController < ApplicationController
  before_action :authenticate_user!

  expose(:observations) do
    current_user.observations.desc(:scheduled_on)
  end
end
