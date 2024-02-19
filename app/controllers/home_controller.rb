class HomeController < ApplicationController
    def index
    end
    def list
        if user_signed_in?
            @buses = Bus.all
          specific_user_id = current_user.id 
          
        else
        end

    end

end