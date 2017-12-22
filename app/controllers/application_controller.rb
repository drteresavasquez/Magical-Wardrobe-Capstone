class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :require_login, :except => [:edit] #prevents unauthenticated user from seeing views
  include SessionsHelper
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "Account activated!"
      redirect_to root_path
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_path
    end
  end

  private
  
    def require_login
      unless current_user
        redirect_to login_url
      end
    end

end
