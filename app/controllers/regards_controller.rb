class RegardsController < ApplicationController
  def create
    result = RegardsSender.execute(current_user, params[:id])
    if result
      flash[:success] = 'Regards sent'
    else
      flash[:danger] = 'Could not send regards'
    end
    redirect_to users_path
  end
end
