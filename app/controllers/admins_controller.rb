class AdminsController < ApplicationController
  def index
    authorize! :manage, User
    @users = User.all
  end
end
