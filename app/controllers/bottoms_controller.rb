class BottomsController < ApplicationController
  include SessionsHelper
 
  def index
    @bottom = Bottom.where(user_id: current_user.id)
  end

  # GET /bottoms/1
  # GET /bottoms/1.json
  def show
    if current_user.id == Bottom.find(params[:id]).user_id
      @bottom = Bottom.find(params[:id])
    else
      redirect_to bottoms_url
    end
  end

  # GET /bottoms/new
  def new
    @bottom = Bottom.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = BottomType.all
  end

  # GET /bottoms/1/edit
  def edit
    if current_user.id == Bottom.find(params[:id]).user_id
      @weather = WeatherType.all
      @style = StyleType.all
      @type = BottomType.all
      @bottom = Bottom.find(params[:id])
    else
      redirect_to bottoms_url
    end
  end

  # POST /bottoms
  # POST /bottoms.json
  def create
    @bottom = Bottom.new(bottom_params)
      if @bottom.save
        flash[:success] = "Bottom was created!"
        redirect_to @bottom
      else
        @weather = WeatherType.all
        @style = StyleType.all
        @type = BottomType.all
        render 'new'
      end
  end


  # PATCH/PUT /bottoms/1
  # PATCH/PUT /bottoms/1.json
  def update
    @bottom = set_bottom
    respond_to do |format|
      if @bottom.update(bottom_params)
        format.html { 
        flash[:success] = 'Bottom was successfully updated.' 
        redirect_to @bottom}
        format.json { render :show, status: :ok, location: @bottom }
      else
        format.html { render :edit }
        format.json { render json: @bottom.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bottoms/1
  # DELETE /bottoms/1.json
  def destroy
    @bottom = Bottom.find(params[:id])
    @bottom.destroy
    respond_to do |format|
      format.html { 
        flash[:success] = 'Bottom was successfully deleted.' 
        redirect_to bottoms_url
       }
      format.json { head :no_content }
    end
  end

  def favorite(id, favorite)
    Bottom.find(params[id]).update(favorite => true)
    redirect_to bottoms_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bottom
      @bottom = Bottom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bottom_params
      params.require(:bottom).permit(:user_id, :name, :picture, :weather_type_id, :active, :bottom_type_id, :favorite, :style_type_id, :description)
    end
end
