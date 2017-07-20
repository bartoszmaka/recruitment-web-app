class RegardsController < ApplicationController
  def create
    RegardsSender.execute(current_user, params[:id])
    flash[:success] = 'Regards sent'
    redirect_to users_path
  end
end
