class IndexController < ApplicationController
    def index
        if current_user
            redirect_to controller: :signalements, action: :index
        end
    end
end