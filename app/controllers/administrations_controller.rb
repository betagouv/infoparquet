class AdministrationsController < ApplicationController
  before_action :authenticate_user!
  before_action except: [:add_user, :remove_user] do authorize_roles ['root'] end
  before_action only: [:add_user, :remove_user] do authorize_roles ['root', 'manager'] end
  before_action :set_administration, only: %i[ show edit update destroy add_user remove_user ]

  def index
    @administrations = Administration.all
  end

  def show
  end

  def new
    @administration = Administration.new
  end

  def edit
  end

  def create
    @administration = Administration.new(administration_params)

    respond_to do |format|
      if @administration.save
        format.html { redirect_to @administration, notice: "Administration créée avec succès !" }
        format.json { render :show, status: :created, location: @administration }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @administration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @administration.update(administration_params)
        format.html { redirect_to @administration, notice: "Administration mise à jour avec succès." }
        format.json { render :show, status: :ok, location: @administration }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @administration.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_user
    params.require(:email)
    user = User.where(email: params[:email]).first()

    if user
        if current_user.role_root?
            user.administration = @administration
        elsif current_user.role_manager? and (user.administration_id == nil or user.administration_id == current_user.administration_id)
            user.administration = @administration
        else
            flash[:error] = "L'utilisateur n'existe pas !"
            redirect_to request.referer
        end

        if user.save
            flash[:notice] = "Utilisateur ajouté avec succès !"
        else
            flash[:error] = user.errors
        end
    else
        flash[:error] = "L'utilisateur n'existe pas !"
    end
    
    redirect_to request.referer
  end

  def remove_user
    params.require(:user_id)

    user = User.find(params[:user_id])

    if user
        if current_user.role_root?
            user.administration = nil
        elsif current_user.role_manager? and current_user.administration_id == user.administration_id
            user.administration = nil
        end

        if user.save
            flash[:notice] = "Utilisateur supprimé avec succès"
        else
            flash[:error] = user.errors
        end
    else
        flash[:error] = "L'utilisateur n'existe pas"
    end

    redirect_to request.referer
  end

  private
    def set_administration
        @administration = Administration.find(params[:id])
    end

    def administration_params
        params.require(:administration).permit(:nom, :code, :departement, :service)
    end
end
