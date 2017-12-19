class SessionsController < ApplicationController
  #this allows the user to login
  # skip_before_action :require_login, :except => [:create]

  def new
    @head = User.find(current_user.id) if logged_in?
    @family_name = Family.find(current_user.family_id) if logged_in? && current_user.family_id != 0
    @family = User.where(family_id: current_user.family_id) if logged_in? && current_user.family_id != 0
    if logged_in? && current_user.family_id = 0
      @top = Top.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
      @bottom = Bottom.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
      @footwear = Footwear.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
      @accessory = Accessory.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
      @outfit = Outfit.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
    elsif logged_in? && current_user.family_admin?
      @top = Top.where(family_id: current_user.family_id).order('id DESC').limit(4) if logged_in?
      @bottom = Bottom.where(family_id: current_user.family_id).order('id DESC').limit(4) if logged_in?
      @footwear = Footwear.where(family_id: current_user.family_id).order('id DESC').limit(4) if logged_in?
      @accessory = Accessory.where(family_id: current_user.family_id).order('id DESC').limit(4) if logged_in?
      @outfit = Outfit.where(family_id: current_user.family_id).order('id DESC').limit(4) if logged_in?
    elsif logged_in? && !current_user.family_admin?
      @outfit = Outfit.where(wearer_id: current_user.id).order('id DESC').limit(4)
      @top = Top.where(wearer_id: current_user.id).order('id DESC').limit(4)
      @bottom = Bottom.where(wearer_id: current_user.id).order('id DESC').limit(4)
      @footwear = Footwear.where(wearer_id: current_user.id).order('id DESC').limit(4)
      @accessory = Accessory.where(wearer_id: current_user.id).order('id DESC').limit(4)
    end

    
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or root_url
      # else
      #   message  = "Account not activated. "
      #   message += "Check your email for the activation link."
      #   flash[:warning] = message
      #   redirect_to root_url
      # end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
