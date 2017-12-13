class AccessoriesController < ApplicationController
  include SessionsHelper  

  # GET /accessories
  # GET /accessories.json
  def index
    @accessory = Accessory.where(user_id: current_user.id)
  end

  # GET /accessories/1
  # GET /accessories/1.json
  def show
    if current_user.id == Accessory.find(params[:id]).user_id
      @accessory = Accessory.find(params[:id])
    else
      redirect_to accessories_url
    end
  end

  # GET /accessories/new
  def new
    @accessory = Accessory.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = AccessoryType.all
    @temp = TemperatureType.all
  end

  # GET /accessories/1/edit
  def edit
    if current_user.id == Accessory.find(params[:id]).user_id
      @weather = WeatherType.all
      @style = StyleType.all
      @type = AccessoryType.all
      @temp = TemperatureType.all
      @accessory = Accessory.find(params[:id])
    else
      redirect_to accessories_url
    end
  end

  # POST /accessories
  # POST /accessories.json
  def create
    @accessory = Accessory.new(accessory_params)
    if @accessory.save
      flash[:success] = "Accessory was created!"
      redirect_to @accessory
    else
      @weather = WeatherType.all
      @style = StyleType.all
      @type = AccessoryType.all
      render 'new'
    end
  end

  # PATCH/PUT /accessories/1
  # PATCH/PUT /accessories/1.json
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

  # DELETE /accessories/1
  # DELETE /accessories/1.json
  def destroy
    @accessory = Accessory.find(params[:id])
    @accessory.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = 'Accessory was successfully destroyed.' 
        redirect_to accessories_url
      }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accessory
      @accessory = Accessory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
        :description)
    end
end
