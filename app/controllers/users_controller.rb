class UsersController < ApplicationController

  def index
    authorize! :index, User
    @users = User.all
  end

  def destroy
    authorize! :destroy, User
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = 'User succesfully deleted'
    redirect_to root_path
  end

  def new
    authorize! :new, User
    @user = User.new
  end

  def create
    authorize! :create, User
    set_default_password
    @user = User.create(user_params)
    if @user.save
      redirect_to admins_path
    else
      render 'new'
    end
  end

  def edit
    authorize! :edit, User
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, User
    ignore_password
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_path
    else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :age, :gender,
      interests_attributes: [:id, :_destroy, :name, :interest_type]
    )
  end

  def set_default_password
    params[:user][:password] = 'secret'
    params[:user][:password_confirmation] = 'secret'
  end

  def ignore_password
    params[:user].delete(:password)
    params[:user].delete(:password_confirmation)
  end
end
