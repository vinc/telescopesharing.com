class Account::TelescopesController < ApplicationController
  before_action :authenticate_user!

  expose(:telescopes) { Telescope.where(user: current_user) }
  expose(:telescope, attributes: :telescope_params)

  def create
    telescope.user = current_user
    if telescope.save
      redirect_to(telescope)
    else
      render :new
    end
  end

  def update
    if telescope.save
      redirect_to(telescope)
    else
      render :edit
    end
  end

  def destroy
    if telescope.destroy
      redirect_to(account_telescopes_path)
    end
  end

  private

  def telescope_params
    params.
      require(:telescope).
      permit(
        :name, :address, :description,
        observations_attributes: [:id, :scheduled_at, :_destroy],
      )
  end
end
