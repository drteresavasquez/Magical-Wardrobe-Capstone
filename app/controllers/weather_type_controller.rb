class WeatherTypesController < ApplicationController
    
    def create
    @weather_type = WeatherType.new(weather_type_params)
   
    end

    private
          def weather_type_params
            params.require(:weather_type).permit(:name)
    
          end
end