class FootwearsController < ApplicationController
  include SessionsHelper

  # GET /footwears
  # GET /footwears.json
  def index
    @footwear = Footwear.where(user_id: current_user.id)
  end

  # GET /footwears/1
  # GET /footwears/1.json
  def show
    if current_user.id == Footwear.find(params[:id]).user_id
      @footwear = Footwear.find(params[:id])
    else
      redirect_to footwears_url
    end
  end

  # GET /footwears/new
  def new
    @footwear = Footwear.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = FootwearType.all
  end

  # GET /footwears/1/edit
  def edit
    if current_user.id == Footwear.find(params[:id]).user_id
      @weather = WeatherType.all
      @style = StyleType.all
      @type = FootwearType.all
      @footwear = Footwear.find(params[:id])
    else
      redirect_to footwears_url
    end
  end

  # POST /footwears
  # POST /footwears.json
  def create
    @footwear = Footwear.new(footwear_params)
      if @footwear.save
          flash[:success] = "Footwear was created!"
          redirect_to @footwear
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = TopType.all
        render 'new'
      end
  end

  # PATCH/PUT /footwears/1
  # PATCH/PUT /footwears/1.json
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

  # DELETE /footwears/1
  # DELETE /footwears/1.json
  def destroy
    @footwear = Footwear.find(params[:id])
    @footwear.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = 'Footwear was successfully deleted.' 
        redirect_to footwears_url
        }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_footwear
      @footwear = Footwear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def footwear_params
      params.require(:footwear).permit(
        :name, 
        :picture, 
        :weather_type_id, 
        :active, 
        :footwear_type_id, 
        :favorite, 
        :style_type_id, 
        :user_id, 
        :description)
    end
end
