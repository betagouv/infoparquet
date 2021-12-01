class IndexController < ApplicationController
    def index
        if current_user
            redirect_to controller: :ds, action: :index
        end
    end
end