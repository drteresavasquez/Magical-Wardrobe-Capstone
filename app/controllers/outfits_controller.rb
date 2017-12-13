class OutfitsController < ApplicationController
  include SessionsHelper
  
  # GET /outfits
  # GET /outfits.json
  def index
    @outfit = Outfit.where(user_id: current_user.id)
  end

  # GET /outfits/1
  # GET /outfits/1.json
  def show
    if current_user.id == Outfit.find(params[:id]).user_id
      @outfit = Outfit.find(params[:id])
      @top = Top.find(@outfit.top_id)
      @bottom = Bottom.find(@outfit.bottom_id)
      unless @outfit.footwear_id.nil?
      @footwear = Footwear.find(@outfit.footwear_id)
      else 
        @footwear = 0
      end
      unless @outfit.accessory_id.nil?
      @accessory = Accessory.find(@outfit.accessory_id)
      else
        @accessory = 0
      end
    else
      redirect_to outfits_url
    end
  end

  # GET /outfits/new
  def new
    @outfit = Outfit.new
    @weather = WeatherType.all
    @style = StyleType.all
    @temp = TemperatureType.all
    @top = Top.where(user_id: current_user.id)
    @bottom = Bottom.where(user_id: current_user.id)
    @accessory = Accessory.where(user_id: current_user.id)
    @footwear = Footwear.where(user_id: current_user.id)
  end

  # GET /outfits/1/edit
  def edit
    if current_user.id == Outfit.find(params[:id]).user_id
      @weather = WeatherType.all
      @style = StyleType.all
      @temp = TemperatureType.all
      @outfit = Outfit.find(params[:id])
      @top = Top.where(user_id: current_user.id)
      @bottom = Bottom.where(user_id: current_user.id)
      @accessory = Accessory.where(user_id: current_user.id)
      @footwear = Footwear.where(user_id: current_user.id)
    else
      redirect_to outfits_url
    end
  end

  # POST /outfits
  # POST /outfits.json
  def create
    @outfit = Outfit.new(outfit_params)
    if @outfit.save
      flash[:success] = 'Outfit was successfully created.'
      redirect_to @outfit
    else
      @weather = WeatherType.all
      @style = StyleType.all
      @top = Top.where(user_id: current_user.id)
      @bottom = Bottom.where(user_id: current_user.id)
      @accessory = Accessory.where(user_id: current_user.id)
      @footwear = Footwear.where(user_id: current_user.id)
      @temp = TemperatureType.all
      render 'new'
    end
  end

  # PATCH/PUT /outfits/1
  # PATCH/PUT /outfits/1.json
  def update
    @outfit = set_outfit
    if @outfit.active?
    Top.where(user_id: current_user.id, id: @outfit.top_id).update_all(:active => false)
      Bottom.where(user_id: current_user.id, id: @outfit.bottom_id).update_all(:active => false)
    else
      Top.where(user_id: current_user.id, id: @outfit.top_id).update_all(:active => true)
      Bottom.where(user_id: current_user.id, id: @outfit.bottom_id).update_all(:active => true)
    end
    respond_to do |format|
      if @outfit.update(outfit_params)
        format.html { 
          flash[:success] = 'Outfit was successfully updated.' 
          redirect_to @outfit
        }
        format.json { render :show, status: :ok, location: @outfit }
      else
        format.html { render :edit }
        format.json { render json: @outfit.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /outfits/1
  # DELETE /outfits/1.json
  def destroy
    @outfit = Outfit.find(params[:id])
    @outfit.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = 'Outfit was successfully deleted.' 
        redirect_to outfits_url 
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outfit
      @outfit = Outfit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outfit_params
      params.require(:outfit).permit(
        :top_id, 
        :name,
        :bottom_id, 
        :accessory_id, 
        :footwear_id, 
        :weather_type_id, 
        :user_id, 
        :active, 
        :favorite, 
        :picture, 
        :style_type_id,
        :temperature_type_id,
        :description
        )
    end
end
