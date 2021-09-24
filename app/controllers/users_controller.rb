class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action do authorize_roles ["root"] end


    def index
        @users = User.all
    end

end
