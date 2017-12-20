class HamperController < ApplicationController
  def index
    wearer = User.where(family_id: current_user.family_id)

    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @top = Top.where(wearer_id: wearer, active:false)
      @bottom = Bottom.where(wearer_id: wearer, active:false)
      @outfit = Outfit.where(wearer_id: wearer, active:false)
    elsif !current_user.family_admin?
      @top = Top.where(wearer_id: current_user.id, active:false)
      @bottom = Bottom.where(wearer_id: current_user.id, active:false)
      @outfit = Outfit.where(wearer_id: current_user.id, active:false)

    end
  end

  def wash_all
    wearer = User.where(family_id: current_user.family_id)

    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      Top.where(wearer_id: wearer, active:false).update_all(:active => true)
      Bottom.where(wearer_id: wearer, active:false).update_all(:active => true)
      Outfit.where(wearer_id: wearer, active:false).update_all(:active => true)
      redirect_to hamper_path
    elsif !current_user.family_admin?
      Top.where(wearer_id: current_user.id, active:false).update_all(:active => true)
      Bottom.where(wearer_id: current_user.id, active:false).update_all(:active => true)
      Outfit.where(wearer_id: current_user.id, active:false).update_all(:active => true)
      redirect_to hamper_path
    end
  end
end
