class OutterwearTypesController < ApplicationController
    
    def create
    @outterwear_type = OutterwearType.new(outterwear_type_params)
   
    end

    private
          def outterwear_type_params
            params.require(:outterwear_type).permit(:name)
    
          end
end