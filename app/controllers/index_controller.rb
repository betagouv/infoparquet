class IndexController < ApplicationController
    def index
        if current_user
            if current_user.role_root? or current_user.administration_id != nil
                redirect_to controller: :signalements, action: :index
            end
        end
    end
end