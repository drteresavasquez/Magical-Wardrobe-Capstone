class FamiliesController < ApplicationController
  before_action :set_family, only: [:show, :edit, :update, :destroy]
  # include SessionHelper

  # GET /families
  # GET /families.json
  def index
    @head = User.find(current_user.id)
    unless current_user.family_id == 0
    @family_name = Family.find(current_user.family_id)
    @family = User.where(family_id: current_user.family_id)
    end
  end

  # GET /families/1
  # GET /families/1.json
  def show
  end

  def new_member
    @new_fam = User.new
  end

  # GET /families/new
  def new
    @head = User.find(current_user.id)
    if @head.family_id == 0
    @family = Family.new
    else
      redirect_to root_path
    end
  end

  # GET /families/1/edit
  def edit
  end

  # POST /families
  # POST /families.json
  def create
    @family = Family.new(family_params)
    if @family.save
      User.where(id: current_user.id).update_all(:family_id => @family.id, :family_admin => true)
      flash[:success] = "Family was created!"
      redirect_to root_path
    else
      render 'new'
    end
  end

  # PATCH/PUT /families/1
  # PATCH/PUT /families/1.json
  def update
    @family = set_family
    respond_to do |format|
      if @family.update(family_params)
        format.html { 
          flash[:success] = 'Family was successfully updated.' 
          redirect_to root_path}
        format.json { render :show, status: :ok, location: @family }
      else
        format.html { render :edit }
        format.json { render json: @family.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /families/1
  # DELETE /families/1.json
  def destroy
    @family.destroy
    User.where(family_id: current_user.family_id).update_all(:family_id => 0, :family_admin => false)
    respond_to do |format|
      format.html { 
        flash[:success] = 'Family was successfully deleted.' 
        redirect_to root_path}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_family
      @family = Family.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def family_params
      params.require(:family).permit(
        :user_id, 
        :admin, 
        :family_id,
        :family_name)
    end

    def user_params
      params.require(:user).permit(
        :name, 
        :email, 
        :zip_code, 
        :password,
        :password_confirmation,
        :family_id,
        :family_admin)
    end
end
