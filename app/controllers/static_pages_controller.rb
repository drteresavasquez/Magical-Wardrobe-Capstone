class StaticPagesController < ApplicationController
  def home
    # @top = Top.where(user_id: current_user.id).order('id DESC').limit(4) if logged_in?
    # #@bottom
    # #@footwear
    # #@accessory
    # #@outfit
  end

  def help
  end

  def about
  end

  def contact
  end
end
