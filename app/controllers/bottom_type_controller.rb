class BottomTypesController < ApplicationController
    
    def create
    @bottom_type = BottomType.new(bottom_type_params)
   
    end

    private
          def bottom_type_params
            params.require(:bottom_type).permit(:name)
    
          end
end