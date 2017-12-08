class StyleTypesController < ApplicationController
    
    def create
    @style_type = StyleType.new(style_type_params)
   
    end

    private
          def style_type_params
            params.require(:style_type).permit(:name)
    
          end
end