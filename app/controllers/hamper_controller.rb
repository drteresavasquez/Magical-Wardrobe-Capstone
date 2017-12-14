class HamperController < ApplicationController
  def index
    if current_user.nil?
      redirect_to login_path
    else
    @top = Top.where(user_id: current_user.id, active:false)
    @bottom = Bottom.where(user_id: current_user.id, active:false)
    @outfit = Outfit.where(user_id: current_user.id, active:false)
    end

  end

  def wash_all
    if current_user.nil?
      redirect_to login_path
    else
    Top.where(user_id: current_user.id, active:false).update_all(:active => true)
    Bottom.where(user_id: current_user.id, active:false).update_all(:active => true)
    Outfit.where(user_id: current_user.id, active:false).update_all(:active => true)
    redirect_to hamper_path
  end
end
end
