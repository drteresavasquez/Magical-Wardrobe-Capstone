class HamperController < ApplicationController
  def index
    @top = Top.where(user_id: current_user.id, active:false)
    # @bottom = Top.where(user_id: current_user.id, active:false)
  end
end
