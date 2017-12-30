class OutterwearsController < ApplicationController
  include SessionsHelper

  def index
    wearer = User.where(family_id: current_user.family_id) if logged_in?

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.family_admin?
      @outterwear= Outterwear.where(wearer_id: wearer).order(:wearer_id).order(:item_id)
      else
      @outterwear = Outterwear.where(wearer_id: current_user.id).order(:item_id)
      end
    end
  end

  # GET /outterwears/1
  # GET /outterwears/1.json
  def show
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Outterwear.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Outterwear.find(params[:id]).user_id).family_id 
        @outterwear = Outterwear.find(params[:id])
      else
        redirect_to outterwears_url
      end
    end
  end

  # GET /outterwears/new
  def new
    @outterwear = Outterwear.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = OutterwearType.all
    @temp = TemperatureType.all
    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @person = User.where(family_id:current_user.family_id)
    elsif !current_user.family_admin?
    end
  end

  # GET /outterwears/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Outterwear.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Outterwear.find(params[:id]).user_id).family_id
        @weather = WeatherType.all
        @style = StyleType.all
        @type = OutterwearType.all
        @temp = TemperatureType.all
        @outterwear = Outterwear.find(params[:id])
        @person = User.where(family_id:current_user.family_id)
      else
        redirect_to outterwears_url
      end
    end
  end

  # POST /outterwears
  # POST /outterwears.json
  def create
    if current_user.nil?
      redirect_to login_path
    else
    @outterwear = Outterwear.new(outterwear_params)
      if @outterwear.save

      # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
      count = Outterwear.where(:wearer_id => @outterwear.wearer_id).count
      highest = Outterwear.where(:wearer_id => @outterwear.wearer_id).maximum(:item_id)

      # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
      item_array = Outterwear.where(:wearer_id => @outterwear.wearer_id).pluck(:item_id)
      unless highest.nil?
        if highest >= count
          array = (1..highest)
          array.each do |num|
              if item_array.include?(num)
                p "taken"
              else
                @outterwear.update(item_id: num)
                break
              end
            end
          else
        @outterwear.update(item_id: count)
        end
      else
        @outterwear.update(item_id: count)
      end
        flash[:success] = "Outterwear was created!"
        redirect_to @outterwear
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = OutterwearType.all
        @temp = TemperatureType.all
        render 'new'
      end
    end
  end

  # PATCH/PUT /outterwears/1
  # PATCH/PUT /outterwears/1.json
  def update
    @outterwear = set_outterwear
    if @outterwear.active?
      Outfit.where(user_id: current_user.id, top_id: @outterwear.id).update_all(:active => false)
    end
    respond_to do |format|
      if @outterwear.update(outterwear_params)
        format.html { 
          flash[:success] = 'Outterwear was successfully updated.' 
          redirect_to @outterwear
        }
        format.json { render :show, status: :ok, location: @outterwear }
            # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
            count = Outterwear.where(:wearer_id => @outterwear.wearer_id).count
            highest = Outterwear.where(:wearer_id => @outterwear.wearer_id).maximum(:item_id)

            # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
            item_array = Outterwear.where(:wearer_id => @outterwear.wearer_id).pluck(:item_id)
            unless highest.nil?
              if highest >= count
                array = (1..highest)
                array.each do |num|
                    if item_array.include?(num)
                      p "taken"
                    else
                      @outterwear.update(item_id: num)
                      break
                    end
                  end
                else
              @outterwear.update(item_id: count)
              end
            else
              @outterwear.update(item_id: count)
            end
      else
        format.html { render :edit }
        format.json { render json: @outterwear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outterwears/1
  # DELETE /outterwears/1.json
  def destroy
    admin_user = User.find(current_user.id)
    if (admin_user.family_admin? && admin_user.family_id == User.find(Outterwear.find(params[:id]).wearer_id).family_id) || User.find(current_user.id).family_id == 0
      @outterwear = Outterwear.find(params[:id])
      outfits = Outfit.where(outterwear_id: @outterwear.id)
      if outfits.any?
        outfits.each do |outfit|
          Outfit.where(outterwear_id: @outterwear.id).update_all(:outterwear_id => nil)
          end
        @outterwear.destroy
        respond_to do |format|
          format.html { 
            flash[:success] = 'Outterwear was successfully deleted.' 
            redirect_to outterwears_url 
            }
          format.json { head :no_content }
            end
      else
        @outterwear.destroy
        respond_to do |format|
          format.html { 
            flash[:success] = 'Outterwear was successfully deleted.' 
            redirect_to outterwears_url 
            }
          format.json { head :no_content }
          end
      end
    else
      flash[:error] = 'You do not have permission to delete.'
      redirect_to outterwears_url
    end
  end

  private
    def set_outterwear
      @outterwear = Outterwear.find(params[:id])
    end

    def outterwear_params
      params.require(:outterwear).permit(
        :user_id, 
        :name, 
        :temperature_type_id, 
        :weather_type_id, 
        :outterwear_type_id, 
        :style_type_id, 
        :description, 
        :favorite, 
        :picture, 
        :active,
        :wearer_id,
        :item_id)
    end
end
