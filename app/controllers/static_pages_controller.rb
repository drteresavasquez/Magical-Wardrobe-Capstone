class StaticPagesController < ApplicationController
  def home
    @top = Top.where(user_id: current_user.id) if logged_in?
    
  end

  def help
  end

  def about
  end

  def contact
  end
end
