require './lib/open_weather'

class RandomController < ApplicationController
  include SessionsHelper
  
  def outfit

    user = User.find(current_user.id)
    zip = user.zip_code
    current_weather = OpenWeather.new(zip)
    response = current_weather.get_weather
    @weather = response['list'][1]['weather'][0]['main']
    if @weather == "Rain"
      @weather_code = 1
    elsif @weather == "Sunny"
      @weather_code = 2
    elsif @weather == "Snow"
      @weather_code = 3
    elsif @weather == "Clear"
      @weather_code = 4
    else
      @weather_code = 5
    end

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

    wearer = User.where(family_id: current_user.family_id)
    
    @temp_type = TemperatureType.find(@temp_code).name
    outfit = Outfit.where(wearer_id: current_user.id, temperature_type_id: @temp_code, active:true)
    any_outfit = Outfit.where(wearer_id: current_user.id, temperature_type_id: 5, active:true)
    outterwear = Outterwear.where(wearer_id: current_user.id, temperature_type_id: @temp_code, active:true)
    any_outterwear = Outterwear.where(wearer_id: current_user.id, temperature_type_id: 5, active:true)

    if @weather_code == 1
      accessory = Accessory.where(wearer_id: current_user.id, weather_type_id: @weather_code, active:true)
      unless accessory.empty?
        @rand_accessory = accessory[Random.rand(accessory.count)]
      else
        @rand_accessory == 0
      end
    else
      @rand_accessory == 0
    end
    
    
    #if both the temp and any outfit categories are empty show none
    if outfit.empty? && any_outfit.empty?
      @selected == nil
    
    #if the temp outfit is empty, but there are outfits in the "any" category, show those.
    elsif outfit.empty? && !any_outfit.empty?
      rand_outfit = any_outfit[Random.rand(any_outfit.count)]
      @selected = rand_outfit
  
      if @selected.outterwear_id.nil? && (@temp_code == 2 || @temp_code == 1)
          if outterwear.empty? && any_outterwear.empty?
            @rand_outterwear == 0
          elsif outterwear.empty? && !any_outterwear.empty?
            @rand_outterwear = any_outterwear[Random.rand(any_outterwear.count)]
          elsif !outterwear.empty? && any_outterwear.empty?
            @rand_outterwear = outterwear[Random.rand(outterwear.count)]
          else
            @rand_outterwear == 0
          end
      else
        @rand_outterwear == 0
      end
    
    # if there are outfits that meet the weather type, show those
    elsif !outfit.empty? && any_outfit.empty?
      rand_outfit = outfit[Random.rand(outfit.count)]
      @selected = rand_outfit

      if @selected.outterwear_id.nil? && (@temp_code == 2 || @temp_code == 1)
        if outterwear.empty? && any_outterwear.empty?
          @rand_outterwear == 0
        elsif outterwear.empty? && !any_outterwear.empty?
          @rand_outterwear = any_outterwear[Random.rand(any_outterwear.count)]
        elsif !outterwear.empty? && any_outterwear.empty?
          @rand_outterwear = outterwear[Random.rand(outterwear.count)]
        else
          @rand_outterwear == 0
        end
      else
        @rand_outterwear == 0
      end

    else
      @selected == nil
    end

    p "Temp: #{@temp}F Code: #{@temp_code} and weather = #{@weather}"
  end

  def clothes
  end
end
