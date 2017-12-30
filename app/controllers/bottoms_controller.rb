class BottomsController < ApplicationController
  include SessionsHelper
 
  def index
    wearer = User.where(family_id: current_user.family_id) if logged_in?

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.family_admin?
        @bottom = Bottom.where(wearer_id: wearer).order(:wearer_id).order(:item_id)
      else
        @bottom = Bottom.where(wearer_id: current_user.id)
      end
    end
  end

  def show

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Bottom.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Bottom.find(params[:id]).user_id).family_id 
        @bottom = Bottom.find(params[:id])
      else
        redirect_to bottoms_url
      end
    end

  end

  def new
    @bottom = Bottom.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = BottomType.all
    @temp = TemperatureType.all
    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @person = User.where(family_id:current_user.family_id)
    elsif !current_user.family_admin?
    end
  end

  # GET /bottoms/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Bottom.find(params[:id]).user_id  || current_user.family_admin? && current_user.family_id == User.find(Bottom.find(params[:id]).user_id).family_id
        @weather = WeatherType.all
        @style = StyleType.all
        @type = BottomType.all
        @temp = TemperatureType.all
        @bottom = Bottom.find(params[:id])
        @person = User.where(family_id:current_user.family_id)
      else
        redirect_to bottoms_url
      end
    end
  end

  # POST /bottoms
  # POST /bottoms.json
  def create
    if current_user.nil?
      redirect_to login_path
    else
      @bottom = Bottom.new(bottom_params)
      if @bottom.save
        # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
          count = Bottom.where(:wearer_id => @bottom.wearer_id).count
          highest = Bottom.where(:wearer_id => @bottom.wearer_id).maximum(:item_id)
          item_array = Bottom.where(:wearer_id => @bottom.wearer_id).pluck(:item_id)
        unless highest.nil?
          if highest >= count
            array = (1..highest)
            array.each do |num|
                if item_array.include?(num)
                  p "taken"
                else
                  @bottom.update(item_id: num)
                  break
                end
              end
          else
          # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
          @bottom.update(item_id: count)
          end
        else
          @bottom.update(item_id: count)
        end

        flash[:success] = "Bottom was created!"
        redirect_to @bottom
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = BottomType.all
        @temp = TemperatureType.all
        render 'new'
      end
    end
  end

  def update
    @bottom = set_bottom
    if @bottom.active?
    Outfit.where(user_id: current_user.id, bottom_id: @bottom.id).update_all(:active => false)
    end
    respond_to do |format|
      if @bottom.update(bottom_params)
        format.html { 
        flash[:success] = 'Bottom was successfully updated.' 
        redirect_to @bottom}
        format.json { render :show, status: :ok, location: @bottom }
        # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
        count = Bottom.where(:wearer_id => @bottom.wearer_id).count
        highest = Bottom.where(:wearer_id => @bottom.wearer_id).maximum(:item_id)
        item_array = Bottom.where(:wearer_id => @bottom.wearer_id).pluck(:item_id)
      unless highest.nil?
        if highest >= count
          array = (1..highest)
          array.each do |num|
              if item_array.include?(num)
                p "taken"
              else
                @bottom.update(item_id: num)
                break
              end
            end
        else
        # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
        @bottom.update(item_id: count)
        end
      else
        @bottom.update(item_id: count)
      end
      else
        format.html { render :edit }
        format.json { render json: @bottom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bottoms/1
  # DELETE /bottoms/1.json
  def destroy
    admin_user = User.find(current_user.id)
    if (admin_user.family_admin? && admin_user.family_id == User.find(Bottom.find(params[:id]).wearer_id).family_id) || User.find(current_user.id).family_id == 0
      @bottom = Bottom.find(params[:id])
      outfits = Outfit.where(bottom_id: @bottom.id)
      if outfits.any?
        outfits.each do |outfit|
          outfit.destroy
        end
      @bottom.destroy
      respond_to do |format|
        format.html { 
          flash[:success] = 'Bottom was successfully deleted.' 
          redirect_to bottoms_url
        }
        format.json { head :no_content }
        end
      else
        @bottom.destroy
      respond_to do |format|
        format.html { 
          flash[:success] = 'Bottom was successfully deleted.' 
          redirect_to bottoms_url
        }
        format.json { head :no_content }
        end
      end
    else
      flash[:error] = 'You do not have permission to delete.'
      redirect_to bottoms_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bottom
      @bottom = Bottom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bottom_params
      params.require(:bottom).permit(
        :user_id, 
        :name, 
        :picture, 
        :weather_type_id, 
        :active, 
        :bottom_type_id, 
        :favorite, 
        :style_type_id, 
        :temperature_type_id, 
        :description,
        :wearer_id)
    end
end
