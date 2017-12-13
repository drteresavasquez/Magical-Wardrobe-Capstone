require 'rubygems'
require 'httparty'

class OpenWeather
    include HTTParty
    base_uri 'api.openweathermap.org/data/2.5/'

    attr_accessor :zip, :apikey

    def initialize(zip)
        self.zip = zip
        self.apikey = "ea2449ceaa9da5d4322f0604b9c58bd9"
    end

    def get_weather
        response = self.class.get("/forecast?zip=#{zip},us&units=imperial&appid=#{apikey}")
        if response.success?
            return response
        else
            raise response.response
        end
    end

end