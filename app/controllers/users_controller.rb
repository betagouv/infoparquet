class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :deny_user
    before_action :set_user, only: [:show, :edit, :update]

    def index
        if current_user.role_root?
            @users = User.all
        elsif current_user.role_manager? and current_user.administration_id != nil
            @users = User.where(administration_id: current_user.administration_id)
        else
            raise ActionController::RoutingError.new('Forbidden')
        end
    end

    def show
    end

    def edit
    end

    def update
        p = params.require(:user).permit(:role)

        respond_to do |format|
            if current_user.role_manager? and (!['manager', 'user'].include? params[:user][:role] or @user.role_root?)
                flash[:error] = "Vous n'êtes pas autorisé à effectuer cette opération"
                format.html { render :index, status: :unprocessable_entity }
            elsif @user.update(p)
                format.html { redirect_to :users, notice: "L'utilisateur a bien été mis à jour !" }
            else
                flash[:error] = @user.errors
                format.html { render :index, status: :unprocessable_entity }
            end
        end
    end

    private
        def deny_user
            if current_user.role_user? or (!current_user.role_root? and current_user.administration_id == nil)
                raise ActionController::RoutingError.new('Forbidden')
            end
        end

        def set_user
            if current_user.role_root?
                @user = User.find(params[:id])
            else
                @user = User.where(id: params[:id], administration_id: [current_user.administration_id, nil]).first()
            end
        end

end
