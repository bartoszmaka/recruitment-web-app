class UsersController < ApplicationController
  def index
    if can? :read, User
      @users = User.all
    else
      redirect_to new_user_session_path
    end
  end

  def destroy
    if can? :destroy, User
      @user = User.find(params[:id])
      @user.destroy
      flash[:notice] = 'User succesfully deleted'
    else
      flash[:danger] = 'You are not authorized to do that'
    end
    redirect_to root_path
  end
end
