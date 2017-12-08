class AccessoryTypesController < ApplicationController
    
    def create
    @accessory_type = AccessoryType.new(accessory_type_params)
   
    end

    private
          def accessory_type_params
            params.require(:accessory_type).permit(:name)
    
          end
end