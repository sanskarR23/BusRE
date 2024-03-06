class HomeController < ApplicationController
    def index
    end
    def list
        if user_signed_in?
            @buses = Bus.all
            @buses = @buses.search(params[:search]) if params[:search].present?
          
        else
        end

    end

end
