class HamperController < ApplicationController
  def index
    @top = Top.where(user_id: current_user.id, active:false)
    @bottom = Bottom.where(user_id: current_user.id, active:false)
    @outfit = Outfit.where(user_id: current_user.id, active:false)

  end

  def wash_all
    Top.where(user_id: current_user.id, active:false).update_all(:active => true)
    Bottom.where(user_id: current_user.id, active:false).update_all(:active => true)
    Outfit.where(user_id: current_user.id, active:false).update_all(:active => true)
    redirect_to hamper_path
  end
end
