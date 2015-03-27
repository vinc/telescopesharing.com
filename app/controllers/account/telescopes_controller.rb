class Account::TelescopesController < ApplicationController
  before_action :authenticate_user!

  expose(:telescopes) { Telescope.where(user: current_user) }
end
