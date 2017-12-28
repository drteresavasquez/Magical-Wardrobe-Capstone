class AccessoriesController < ApplicationController
  include SessionsHelper  

  def index
    wearer = User.where(family_id: current_user.family_id) if logged_in?

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.family_admin?
        @accessory = Accessory.where(wearer_id: wearer).order(:wearer_id)
      else
        @accessory = Accessory.where(wearer_id: current_user.id)
      end
    end
  end

  def show
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Accessory.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Accessory.find(params[:id]).user_id).family_id 
        @accessory = Accessory.find(params[:id])
      else
        redirect_to accessories_url
      end
    end
  end

  def new
    @accessory = Accessory.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = AccessoryType.all
    @temp = TemperatureType.all
    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @person = User.where(family_id:current_user.family_id)
    elsif !current_user.family_admin?
    end
  end

  def edit
    if current_user.nil?
      redirect_to login_path
    else
    if current_user.id == Accessory.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Accessory.find(params[:id]).user_id).family_id
      @accessory = Accessory.find(params[:id]) 
      @weather = WeatherType.all
      @style = StyleType.all
      @type = AccessoryType.all
      @temp = TemperatureType.all
      @person = User.where(family_id:current_user.family_id)
    else
      redirect_to accessories_url
    end
    end
  end

  def create
    if current_user.nil?
      redirect_to login_path
    else
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      # give the item an incermental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
      count = Accessory.where(:wearer_id => @accessory.wearer_id).count
      @accessory.update(item_id: count)

      #once the item id is assigned, success!
      flash[:success] = "Accessory was created!"
      redirect_to @accessory
    else
      @weather = WeatherType.all
      @style = StyleType.all
      @type = AccessoryType.all
      @temp = TemperatureType.all
      @person = User.where(family_id:current_user.family_id)
      render 'new'
    end
    end
  end

  def update
    @accessory = set_accessory
    respond_to do |format|
      if @accessory.update(accessory_params)
        format.html { 
          flash[:success] = 'Accessory was successfully updated.'
          redirect_to @accessory
        }
        format.json { render :show, status: :ok, location: @accessory }
      else
        format.html { render :edit }
        format.json { render json: @accessory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    admin_user = User.find(current_user.id)
    if (admin_user.family_admin? && admin_user.family_id == User.find(Accessory.find(params[:id]).wearer_id).family_id) || User.find(current_user.id).family_id == 0
    @accessory = Accessory.find(params[:id])
    outfits = Outfit.where(accessory_id: @accessory.id)
        if outfits.any?
          outfits.each do |outfit|
            Outfit.where(accessory_id: @accessory.id).update_all(:accessory_id => nil)
          end
          @accessory.destroy
          respond_to do |format|
            format.html { 
              flash[:success] = 'Accessory was successfully destroyed.' 
              redirect_to accessories_url
            }
            format.json { head :no_content }
          end
        else
          @accessory.destroy
          respond_to do |format|
            format.html { 
              flash[:success] = 'Accessory was successfully destroyed.' 
              redirect_to accessories_url
            }
            format.json { head :no_content }
          end
        end
    else
      flash[:error] = 'You do not have permission to delete.'
      redirect_to accessories_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessory
      @accessory = Accessory.find(params[:id])
    end

    def accessory_params
      params.require(:accessory).permit(
        :name, 
        :picture, 
        :active, 
        :weather_type_id, 
        :accessory_type_id,
        :favorite, 
        :style_type_id, 
        :temperature_type_id, 
        :user_id, 
        :description,
        :wearer_id)
    end
end
