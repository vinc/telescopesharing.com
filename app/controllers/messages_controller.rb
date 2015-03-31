class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_user, only: [:edit, :update, :destroy]

  expose(:messages)
  expose(:message, attributes: :message_params)

  def create
    message.user = current_user # FIXME: Add author relation

    if message.save
      redirect_to(:back)
    else
      render :new
    end
  end

  def update
    if message.save
      redirect_to(:back)
    else
      render :edit
    end
  end

  def destroy
    if message.destroy
      redirect_to(:back)
    end
  end

  private

  def require_user
    unless message.author == current_user
      flash[:error] = "Sorry, you cannot perform this operation."
      redirect_to(:back)
    end
  end

  def message_params
    params.require(:message).permit(:content, :observation_id)
  end
end
