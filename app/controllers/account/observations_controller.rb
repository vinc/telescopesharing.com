class Account::ObservationsController < ApplicationController
  before_action :authenticate_user!

  expose(:observations) do
    Observation.in(telescope: current_user.telescopes.to_a).desc(:scheduled_on)
  end
end
