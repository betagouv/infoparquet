class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action do authorize_roles ["root"] end


    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
    end
end
