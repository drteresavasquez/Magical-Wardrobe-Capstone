class RandomController < ApplicationController

  def outfit
    weather = OpenWeather.new("37013")
    response = weather.get_weather

    temp = response['list'][0]['main']['temp']
    weather = response['list'][1]['weather'][0]['main']
    p "Temp = #{temp} and weather = #{weather}"
  end

  def clothes
  end
end
