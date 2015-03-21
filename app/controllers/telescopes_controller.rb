class TelescopesController < ApplicationController
  expose(:telescopes)
  expose(:telescope)

  def create
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
end
