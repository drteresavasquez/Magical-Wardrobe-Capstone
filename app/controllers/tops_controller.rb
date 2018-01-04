class TopsController < ApplicationController
  include SessionsHelper

  #limits users to view only their tops
  def index
    wearer = User.where(family_id: current_user.family_id) if logged_in?
    @path = tops_path
    @search_name = "Tops"

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.family_admin?
      @top = if params[:term]
        user = User.where(:name => "#{params[:term]}")
        p user.ids
        Top.where('name LIKE ? OR wearer_id LIKE ?', "%#{params[:term]}%", "%#{1}%")
        else
        Top.where(wearer_id: wearer).order(:wearer_id).order(:item_id)
         end
      else
      @top = if params[:term]
        Top.where('name LIKE ?', "%#{params[:term]}%")
        else
        Top.where(wearer_id: current_user.id).order(:item_id)
        end
      end
    end
  end

  #show the specific top that is selected only if it belongs to current user
  def show
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Top.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Top.find(params[:id]).user_id).family_id 
        @top = Top.find(params[:id])
      else
        redirect_to tops_url
      end
    end
  end

  #to create a top, all the elements should be present in the form
  def new
    @top = Top.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = TopType.all
    @temp = TemperatureType.all
    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @person = User.where(family_id:current_user.family_id)
    elsif !current_user.family_admin?
    end
  end

  #if top belongs to current user, allow edit
  def edit
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Top.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Top.find(params[:id]).user_id).family_id
        @weather = WeatherType.all
        @style = StyleType.all
        @type = TopType.all
        @temp = TemperatureType.all
        @top = Top.find(params[:id])
        @person = User.where(family_id:current_user.family_id)
      else
        redirect_to tops_url
      end
    end
  end

  def create
    if current_user.nil?
      redirect_to login_path
    else
      @top = Top.new(top_params)
      if @top.save

      # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
      count = Top.where(:wearer_id => @top.wearer_id).count
      highest = Top.where(:wearer_id => @top.wearer_id).maximum(:item_id)
      item_array = Top.where(:wearer_id => @top.wearer_id).pluck(:item_id)
      unless highest.nil?
        if highest >= count
          array = (1..highest)
          array.each do |num|
              if item_array.include?(num)
                p "taken"
              else
                @top.update(item_id: num)
                break
              end
            end
          else
        # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
        @top.update(item_id: count)
        end
      else
        @top.update(item_id: count)
      end
        flash[:success] = "Top was created!"
        redirect_to @top
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = TopType.all
        @temp = TemperatureType.all
        render 'new'
      end
    end
  end

  def update
    @top = set_top
    if @top.active?
      Outfit.where(user_id: current_user.id, top_id: @top.id).update_all(:active => false)
    end
    respond_to do |format|
      if @top.update(top_params)
        format.html { 
          flash[:success] = 'Top was successfully updated.' 
          redirect_to @top
        }
        format.json { render :show, status: :ok, location: @top }
            # updates item ID if a new user is selected for the item
              count = Top.where(:wearer_id => @top.wearer_id).count
              highest = Top.where(:wearer_id => @top.wearer_id).maximum(:item_id)
              item_array = Top.where(:wearer_id => @top.wearer_id).pluck(:item_id)
              unless highest.nil?
                if highest >= count
                  array = (1..highest)
                  array.each do |num|
                      if item_array.include?(num)
                        p "taken"
                      else
                        @top.update(item_id: num)
                        break
                      end
                    end
                  else
                # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
                @top.update(item_id: count)
                end
              else
                @top.update(item_id: count)
              end   
      else
        format.html { render :edit }
        format.json { render json: @top.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    admin_user = User.find(current_user.id)
    if (admin_user.family_admin? && admin_user.family_id == User.find(Top.find(params[:id]).wearer_id).family_id) || User.find(current_user.id).family_id == 0
      @top = Top.find(params[:id])
      outfits = Outfit.where(top_id: @top.id)
      if outfits.any?
        outfits.each do |outfit|
          outfit.destroy
        end
        @top.destroy
        respond_to do |format|
          format.html { 
            flash[:success] = 'Top was successfully deleted.' 
            redirect_to tops_url 
            }
          format.json { head :no_content }
        end
      else
        @top.destroy
        respond_to do |format|
          format.html { 
            flash[:success] = 'Top was successfully deleted.' 
            redirect_to tops_url 
            }
          format.json { head :no_content }
        end
      end
    else
      flash[:error] = 'You do not have permission to delete.'
      redirect_to tops_url
    end
  end

  private

    def set_top
      @top = Top.find(params[:id])
    end

    # Accepts only these params
    def top_params
      params.require(:top).permit(
        :user_id, 
        :name, 
        :weather_type_id, 
        :top_type_id, 
        :style_type_id, 
        :description, 
        :favorite, 
        :active,
        :temperature_type_id,
        :picture,
        :wearer_id)
    end
end
