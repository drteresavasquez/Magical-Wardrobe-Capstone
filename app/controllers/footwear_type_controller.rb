class FootwearTypesController < ApplicationController
    
    def create
    @footwear_type = FootwearType.new(footwear_type_params)
   
    end

    private
          def footwear_type_params
            params.require(:footwear_type).permit(:name)
    
          end
end