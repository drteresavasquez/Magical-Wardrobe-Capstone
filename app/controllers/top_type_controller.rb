class TopTypesController < ApplicationController
    
    def create
    @top_type = TopType.new(top_type_params)
   
    end

    private
          def top_type_params
            params.require(:top_type).permit(:name, :description)
    
          end
end