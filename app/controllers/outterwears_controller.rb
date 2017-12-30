class OutterwearsController < ApplicationController
  before_action :set_outterwear, only: [:show, :edit, :update, :destroy]

  # GET /outterwears
  # GET /outterwears.json
  def index
    @outterwears = Outterwear.all
  end

  # GET /outterwears/1
  # GET /outterwears/1.json
  def show
  end

  # GET /outterwears/new
  def new
    @outterwear = Outterwear.new
  end

  # GET /outterwears/1/edit
  def edit
  end

  # POST /outterwears
  # POST /outterwears.json
  def create
    @outterwear = Outterwear.new(outterwear_params)

    respond_to do |format|
      if @outterwear.save
        format.html { redirect_to @outterwear, notice: 'Outterwear was successfully created.' }
        format.json { render :show, status: :created, location: @outterwear }
      else
        format.html { render :new }
        format.json { render json: @outterwear.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outterwears/1
  # PATCH/PUT /outterwears/1.json
  def update
    respond_to do |format|
      if @outterwear.update(outterwear_params)
        format.html { redirect_to @outterwear, notice: 'Outterwear was successfully updated.' }
        format.json { render :show, status: :ok, location: @outterwear }
      else
        format.html { render :edit }
        format.json { render json: @outterwear.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outterwears/1
  # DELETE /outterwears/1.json
  def destroy
    @outterwear.destroy
    respond_to do |format|
      format.html { redirect_to outterwears_url, notice: 'Outterwear was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outterwear
      @outterwear = Outterwear.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outterwear_params
      params.require(:outterwear).permit(:user_id, :name, :temperature_type_id, :weather_type_id, :outterwear_type_id, :style_type_id, :description, :favorite, :picture, :active)
    end
end
