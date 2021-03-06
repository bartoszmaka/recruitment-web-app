class UsersController < ApplicationController
  def index
    authorize! :index, User
    @q = User.ransack(params[:q])
    @users = @q.result
    respond_to do |format|
      format.html { render 'index' }
      format.csv do
        authorize! :download_csv, User
        send_data CsvParser.execute(@users)
      end
    end
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
    @user = User.create(user_params.merge(password: 'secret'))
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
      :email, :age, :gender,
      interests_attributes: [:id, :_destroy, :name, :interest_type]
    )
  end
end
