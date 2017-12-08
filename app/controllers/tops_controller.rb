class TopsController < ApplicationController
  include SessionsHelper

  def index
    # @tops = Top.all
    @tops = Top.where(user_id: current_user.id)
  end

  def show
    @top = Top.find(params[:id])
  end

  def new
    @top = Top.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = TopType.all
  end

  def edit
    @weather = WeatherType.all
    @style = StyleType.all
    @type = TopType.all
    @top = Top.find(params[:id])
  end

  def create
    @top = Top.new(top_params)
    if @top.save
      flash[:success] = "Top was created!"
      redirect_to @top
    else
      @weather = WeatherType.all
      @style = StyleType.all
      @type = TopType.all
      render 'new'
    end
  end

  def update
    @top = Top.find(params[:id])
    respond_to do |format|
      if @top.update(top_params)
        format.html { redirect_to @top, notice: 'Top was successfully updated.' }
        format.json { render :show, status: :ok, location: @top }
      else
        format.html { render :edit }
        format.json { render json: @top.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @top = Top.find(params[:id])
    @top.destroy
    respond_to do |format|
      format.html { redirect_to tops_url, notice: 'Top was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

    def set_top
      @top = Top.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
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
        :picture)
    end
end
