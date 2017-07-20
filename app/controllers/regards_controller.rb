class RegardsController < ApplicationController
  def create
    RegardsSender.new(current_user, params[:id]).execute
    flash[:success] = 'Regards sent'
    redirect_to users_path
  end
end
