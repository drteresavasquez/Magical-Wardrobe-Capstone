class TopsController < ApplicationController
  include SessionsHelper

  #limits users to view only their tops
  def index
    @top = Top.where(user_id: current_user.id)
  end

  #show the specific top that is selected only if it belongs to current user
  def show
      if current_user.id == Top.find(params[:id]).user_id
        @top = Top.find(params[:id])
      else
        redirect_to tops_url
      end
  end

  #to create a top, all the elements should be present in the form
  def new
    @top = Top.new
    @weather = WeatherType.all
    @style = StyleType.all
    @type = TopType.all
  end

  #if top belongs to current user, allow edit
  def edit
    if current_user.id == Top.find(params[:id]).user_id
      @weather = WeatherType.all
      @style = StyleType.all
      @type = TopType.all
      @top = Top.find(params[:id])
    else
      redirect_to tops_url
    end
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
    @top = set_top
    respond_to do |format|
      if @top.update(top_params)
        format.html { 
          flash[:success] = 'Top was successfully updated.' 
          redirect_to @top
        }
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
      format.html { 
        flash[:success] = 'Top was successfully deleted.' 
        redirect_to tops_url 
        }
      format.json { head :no_content }
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
        :picture)
    end
end
