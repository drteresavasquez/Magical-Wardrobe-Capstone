class OutfitsController < ApplicationController
  include SessionsHelper  
  # GET /outfits
  # GET /outfits.json
  def index
    wearer = User.where(family_id: current_user.family_id)
    # if the current user is the admin, show all outfits for the family
    if current_user.family_admin?
      @tops = Top.where(wearer_id: wearer)
      @bottoms = Bottom.where(wearer_id: wearer)

      # when making the call to view all outfits, check the status of the tops and bottoms to see if the outfit is available to wear
      @tops.each do |top|
        @bottoms.each do |bottom|
        if !top.active?
          Outfit.where(wearer_id: wearer, top_id: top.id).update_all(:active => false) 
        end
          if !bottom.active?
            Outfit.where(wearer_id: wearer, bottom_id: bottom.id).update_all(:active => false) 
          end

          #if both items are available make the outfit available
          if top.active? && bottom.active?
            Outfit.where(wearer_id: wearer, top_id: top.id, bottom_id: bottom.id).update_all(:active => true) 
          end
        end
      end
    #scoped to view to show all wearers in the family if the current user is a family admin
    @outfit = Outfit.where(wearer_id: wearer) 

    #otherwise, only show the user their stuff
    else
    @tops = Top.where(wearer_id: current_user.id)
    @bottoms = Bottom.where(wearer_id: current_user.id)

    # when making the call to view all outfits, check the status of the tops and bottoms to see if the outfit is available to wear
    @tops.each do |top|
      @bottoms.each do |bottom|
      if !top.active?
        Outfit.where(wearer_id: current_user.id, top_id: top.id).update_all(:active => false) 
      end
        if !bottom.active?
          Outfit.where(wearer_id: current_user.id, bottom_id: bottom.id).update_all(:active => false) 
        end

        if top.active? && bottom.active?
          Outfit.where(wearer_id: current_user.id, top_id: top.id, bottom_id: bottom.id).update_all(:active => true) 
        end
      end
    end

    #scoped to view to show current user's outfits if the current user is not a family admin
    @outfit = Outfit.where(wearer_id: current_user.id) 
    end
  end

  def show
    #if the current user is the wearer or the user is the admin of the family, show the outfit details
      if current_user.id == Outfit.find(params[:id]).wearer_id || current_user.family_admin? && current_user.family_id == User.find(Outfit.find(params[:id]).user_id).family_id 
        this_outfit = Outfit.find(params[:id])
        @top = Top.find(this_outfit.top_id)
        @bottom = Bottom.find(this_outfit.bottom_id)
        @wearer = User.find(this_outfit.wearer_id)
        if this_outfit.active? && (!@bottom.active? || !@top.active?)
          Outfit.where(user_id: current_user.id, top_id: @top.id).update_all(:active => false)
          Outfit.where(user_id: current_user.id, bottom_id: @bottom.id).update_all(:active => false)
        elsif !this_outfit.active? && (@bottom.active? || @top.active?)
          Outfit.where(user_id: current_user.id, top_id: @top.id).update_all(:active => true)
          Outfit.where(user_id: current_user.id, bottom_id: @bottom.id).update_all(:active => true)
        end

        @outfit = Outfit.find(params[:id])
      
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
        unless @outfit.outterwear_id.nil?
        @outterwear = Outterwear.find(@outfit.outterwear_id)
        else
          @outterwear = 0
        end
      
      #otherwise, redirect the the outfits home page
      else
        redirect_to outfits_url
      end
  end

  # GET /outfits/new
  def new
    wearer = User.where(family_id: current_user.family_id)
    # elements available to all loggeed in users
    @outfit = Outfit.new
    @weather = WeatherType.all
    @style = StyleType.all
    @temp = TemperatureType.all

    if current_user.nil?
      redirect_to login_path

    #if the family member is the admin of the house, make scope these variables to the view and make all people available to assign outfits
    elsif current_user.family_admin?
      @person = if params[:term]
        User.find("#{params[:term]}")
        else
        @person = User.where(family_id:current_user.family_id).order(:wearer_id)
        end
      
      if params[:term]
      @top = Top.where(wearer_id: @person.id).order(:name)
      @bottom = Bottom.where(wearer_id: @person.id).order(:name)
      @accessory = Accessory.where(wearer_id: @person.id).order(:name)
      @footwear = Footwear.where(wearer_id: @person.id).order(:name)
      @outterwear = Outterwear.where(wearer_id: @person.id).order(:name)
      @person_name = @person.name
      end
      # @top = Top.where(wearer_id: wearer).order(:name)
      # @bottom = Bottom.where(wearer_id: wearer).order(:name)
      # @accessory = Accessory.where(wearer_id: wearer).order(:name)
      # @footwear = Footwear.where(wearer_id: wearer).order(:name)
      # @outterwear = Outterwear.where(wearer_id: wearer).order(:name)
      
    #else, if they are not, scope these instead
    elsif !current_user.family_admin?
      @top = Top.where(wearer_id: current_user.id).order(:name)
      @bottom = Bottom.where(wearer_id: current_user.id).order(:name)
      @accessory = Accessory.where(wearer_id: current_user.id).order(:name)
      @footwear = Footwear.where(wearer_id: current_user.id).order(:name)
      @outterwear = Outterwear.where(wearer_id: current_user.id).order(:name)
      @person = User.find(current_user.id)
      @person_name = @person.name
    end
  end

  # GET /outfits/1/edit
  def edit
    if current_user.nil?
      redirect_to login_path
    else
      # if the current user is the owner of the item OR the current user is the family admin with the same family_id as the owner can update
      if current_user.id == Outfit.find(params[:id]).user_id || current_user.family_admin? && current_user.family_id == User.find(Outfit.find(params[:id]).user_id).family_id
        @weather = WeatherType.all
        @style = StyleType.all
        @temp = TemperatureType.all
        @outfit = Outfit.find(params[:id])
        @top = Top.where(user_id: current_user.id).order(:wearer_id)
        @bottom = Bottom.where(user_id: current_user.id).order(:wearer_id)
        @accessory = Accessory.where(user_id: current_user.id).order(:wearer_id)
        @footwear = Footwear.where(user_id: current_user.id).order(:wearer_id)
        @outterwear = Outterwear.where(user_id: current_user.id).order(:wearer_id)

        # if the current user isn't a part of a family or not a family_admin, they can only edit items for themselves
        if User.find(current_user.id).family_id == 0 || !current_user.family_admin?
          @person = User.find(current_user.id).order(:name)

        #otherwise, a family_admin can edit an outfit for anyone in the family
        else
        @person = User.where(family_id:current_user.family_id)
        end

    #if the user doesn't own it or they are not the family admin, they are redirected to all outfits
    else
      redirect_to outfits_url
    end
    end
  end

  # POST /outfits
  # POST /outfits.json
  def create
    @outfit = Outfit.new(outfit_params)
    if @outfit.save
        # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
      count = Outfit.where(:wearer_id => @outfit.wearer_id).count
      highest = Outfit.where(:wearer_id => @outfit.wearer_id).maximum(:item_id)
      item_array = Outfit.where(:wearer_id => @outfit.wearer_id).pluck(:item_id)
      unless highest.nil?
        if highest >= count
          array = (1..highest)
          array.each do |num|
              if item_array.include?(num)
                p "taken"
              else
                @outfit.update(item_id: num)
                break
              end
            end
          else
        # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
        @outfit.update(item_id: count)
        end
      else
        @outfit.update(item_id: count)
      end
      flash[:success] = 'Outfit was successfully created.'
      redirect_to @outfit
    else
      @weather = WeatherType.all
      @style = StyleType.all
      @top = Top.where(user_id: current_user.id).order(:name)
      @bottom = Bottom.where(user_id: current_user.id).order(:name)
      @accessory = Accessory.where(user_id: current_user.id).order(:name)
      @footwear = Footwear.where(user_id: current_user.id).order(:name)
      @outterwear = Outterwear.where(user_id: current_user.id).order(:name)
      @temp = TemperatureType.all
        if current_user.family_id == 0
          @person = User.find(current_user.id).order(:name)
        else
        @person = User.where(family_id:current_user.family_id).order(:name)
        end
      render 'new'
    end
  end

  # PATCH/PUT /outfits/1
  # PATCH/PUT /outfits/1.json
  def update
    @outfit = set_outfit
    @top = Top.find(@outfit.top_id)
    @bottom =  Bottom.find(@outfit.bottom_id)

      if @outfit.active?
        Top.where(wearer_id: @top.wearer_id, id: @outfit.top_id).update_all(:active => false)
        Bottom.where(wearer_id: @bottom.wearer_id, id: @outfit.bottom_id).update_all(:active => false)
      else
        Top.where(wearer_id: @top.wearer_id, id: @outfit.top_id).update_all(:active => true)
        Bottom.where(wearer_id: @bottom.wearer_id, id: @outfit.bottom_id).update_all(:active => true)
      end

    respond_to do |format|
      if @outfit.update(outfit_params)
        format.html { 
          flash[:success] = 'Outfit was successfully updated.' 
          redirect_to @outfit
        }
        format.json { render :show, status: :ok, location: @outfit }

        # give the item an incremental id so that the line item id isn't used. The user can have incremental ids in order so that item ids can be reused.
      count = Outfit.where(:wearer_id => @outfit.wearer_id).count
      highest = Outfit.where(:wearer_id => @outfit.wearer_id).maximum(:item_id)
      item_array = Outfit.where(:wearer_id => @outfit.wearer_id).pluck(:item_id)
      unless highest.nil?
        if highest >= count
          array = (1..highest)
          array.each do |num|
              if item_array.include?(num)
                p "taken"
              else
                @outfit.update(item_id: num)
                break
              end
            end
          else
        # create a range up to the item_id and iterate through item_ids until I find one that doesn't exist, then assign accessory that ID.
        @outfit.update(item_id: count)
        end
      else
        @outfit.update(item_id: count)
      end
      else
        format.html { render :edit }
        format.json { render json: @outfit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outfits/1
  # DELETE /outfits/1.json
  def destroy
    if current_user.family_id == 0 || current_user.family_admin?
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
  end

  private
    def set_outfit
      @outfit = Outfit.find(params[:id])
    end

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
        :description,
        :wearer_id,
        :outterwear_id
        )
    end
end
