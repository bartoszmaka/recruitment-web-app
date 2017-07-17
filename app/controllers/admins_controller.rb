class AdminsController < ApplicationController
  def index
    if can? :manage, User
      @users = User.all
    else
      redirect_to root_path
    end
  end
end
