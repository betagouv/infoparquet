class IndexController < ApplicationController
    def index
        if current_user
            redirect_to controller: :d_s, action: :index
        end
    end
end