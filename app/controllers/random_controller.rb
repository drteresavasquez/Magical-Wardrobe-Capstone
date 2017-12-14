class RandomController < ApplicationController
  include SessionsHelper
  
  def outfit
    user = User.find(current_user.id)
    zip = user.zip_code
    weather = OpenWeather.new(zip)
    response = weather.get_weather

    @temp = response['list'][0]['main']['temp']
    if @temp >= 85
      @temp_code = 3
    elsif @temp >= 70
      @temp_code = 4
    elsif @temp >= 50
      @temp_code = 2
    else
      @temp_code = 1
    end

    @temp_type = TemperatureType.find(@temp_code).name
    outfit = Outfit.where(user_id: current_user.id, temperature_type_id: @temp_code, active:true)
    rand_outfit = outfit[Random.rand(outfit.count)]
    if outfit.empty?
      @selected = nil
    else
      @selected = rand_outfit
      @top = Top.where(user_id: current_user.id, id: @selected.top_id)
      @bottom = Bottom.where(user_id: current_user.id, id: @selected.bottom_id)

      unless @selected.footwear_id.nil?
        @footwear = Footwear.where(user_id: current_user.id, id: @selected.footwear_id)
        else 
          @footwear = 0
      end

        unless @selected.accessory_id.nil?
          @accessory = Accessory.where(user_id: current_user.id, id: @selected.accessory_id)
        else
          @accessory = 0
        end
    end

    @weather = response['list'][1]['weather'][0]['main']
    p "Temp: #{@temp}F Code: #{@temp_code} and weather = #{@weather}"
  end

  def clothes
  end
end
