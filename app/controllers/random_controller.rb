class RandomController < ApplicationController

  def outfit
    weather = OpenWeather.new("37013")
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

    outfit = Outfit.where(user_id: current_user.id, temperature_type_id: @temp_code, active:true)
    rand_outfit = outfit[Random.rand(outfit.count)]
    if outfit.empty?
      @selected = nil
    else
      @selected = rand_outfit
    end

    @weather = response['list'][1]['weather'][0]['main']
    p "Temp: #{@temp}F Code: #{@temp_code} and weather = #{@weather}"
  end

  def clothes
  end
end
