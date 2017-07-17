class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if current_user
      flash[:danger] = 'You are not authorized to do that'
      redirect_to root_path
    else
      flash[:danger] = 'You should log in first'
      redirect_to new_user_session_path
    end
  end
end
