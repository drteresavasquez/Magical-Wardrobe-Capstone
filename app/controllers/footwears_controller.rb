class FootwearsController < ApplicationController
  include SessionsHelper

  # GET /footwears
  # GET /footwears.json
  def index
    wearer = User.where(family_id: current_user.family_id) if logged_in?

    if current_user.nil?
      redirect_to login_path
    else
      if current_user.family_admin?
      @footwear = Footwear.where(wearer_id: wearer)
      else
      @footwear = Footwear.where(wearer_id: current_user.id)
      end
    end
  end

  # GET /footwears/1
  # GET /footwears/1.json
  def show
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Footwear.find(params[:id]).wearer_id || current_user.family_admin? && current_user.family_id == User.find(Footwear.find(params[:id]).user_id).family_id 
        @footwear = Footwear.find(params[:id])
      else
        redirect_to footwears_url
      end
    end
  end

  # GET /footwears/new
  def new
    @footwear = Footwear.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = FootwearType.all
    @temp = TemperatureType.all
    if current_user.nil?
      redirect_to login_path
    elsif current_user.family_admin?
      @person = User.where(family_id:current_user.family_id)
    elsif !current_user.family_admin?
    end
  end

  # GET /footwears/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path
    else
      if current_user.id == Footwear.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Footwear.find(params[:id]).user_id).family_id
        @weather = WeatherType.all
        @style = StyleType.all
        @type = FootwearType.all
        @temp = TemperatureType.all
        @footwear = Footwear.find(params[:id])
        @person = User.where(family_id:current_user.family_id)
      else
        redirect_to footwears_url
      end
    end
  end

  def create
    if current_user.nil?
      redirect_to login_path
    else
    @footwear = Footwear.new(footwear_params)
      if @footwear.save
          flash[:success] = "Footwear was created!"
          redirect_to @footwear
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = TopType.all
        @temp = TemperatureType.all
        @person = User.where(family_id:current_user.family_id)
        render 'new'
      end
    end
  end

  def update
    @footwear= set_footwear
    respond_to do |format|
      if @footwear.update(footwear_params)
        format.html { 
        flash[:success] = 'Footwear was successfully updated.' 
        redirect_to @footwear
        }
        format.json { render :show, status: :ok, location: @footwear }
      else
        format.html { render :edit }
        format.json { render json: @footwear.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    admin_user = User.find(current_user.id)
    if (admin_user.family_admin? && admin_user.family_id == User.find(Footwear.find(params[:id]).wearer_id).family_id) || User.find(current_user.id).family_id == 0
    @footwear = Footwear.find(params[:id])
    outfits = Outfit.where(footwear_id: @footwear.id)
      if outfits.any?
        outfits.each do |outfit|
          Outfit.where(footwear_id: @footwear.id).update_all(:footwear_id => nil)
        end
        @footwear.destroy
        respond_to do |format|
          format.html { 
            flash[:success] = 'Footwear was successfully deleted.' 
            redirect_to footwears_url
            }
          format.json { head :no_content }
        end
      else
        @footwear.destroy
          respond_to do |format|
            format.html { 
              flash[:success] = 'Footwear was successfully deleted.' 
              redirect_to footwears_url
              }
            format.json { head :no_content }
          end
      end
    else
        flash[:error] = 'You do not have permission to delete.'
        redirect_to footwears_url
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footwear
      @footwear = Footwear.find(params[:id])
    end

    def footwear_params
      params.require(:footwear).permit(
        :name, 
        :picture, 
        :weather_type_id, 
        :active, 
        :footwear_type_id, 
        :favorite, 
        :style_type_id, 
        :temperature_type_id, 
        :user_id, 
        :description,
        :wearer_id)
    end
end
