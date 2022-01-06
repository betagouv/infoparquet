class SignalementsController < ApplicationController
  before_action :authenticate_user!
  before_action :enrolled_user!
  before_action :set_signalement, only: %i[ show edit update destroy ]

  # GET /signalements or /signalements.json
  def index
    @search = params[:search]
    @urgence = ["true", "oui", "1", 1].include? params[:urgence]
    @page = params[:page].to_i || 0
    @limit = !params[:limit] || params[:limit].to_i <= 0 ? 10 : params[:limit].to_i

    #manager/user -> all signalements for admin
    #root -> all signalements
    query = nil
    if current_user.role_root?
        query = Signalement
    else
        query = Signalement.where administration_id: current_user.administration_id
    end


    if @urgence
        query = query.where urgence: true
    end

    if @search
        query = query.where(
            'reference_administration ILIKE :startswith
            OR nataff ILIKE :startswith
            OR natinf ILIKE :startswith
            OR idj ILIKE :startswith
            OR lieux_faits ILIKE :contains', 
            startswith: "#{@search}%",
            contains: "%#{@search}%"
        )
    end

    @pageCount = query.count() / @limit
    @signalements = query.limit(@limit).offset(@page*@limit)
  end

  # GET /signalements/1 or /signalements/1.json
  def show
  end

  # GET /signalements/new
  def new
    @signalement = Signalement.new
    @signalement.administration = current_user.administration
    @signalement.createur = current_user
  end

  # GET /signalements/1/edit
  def edit
  end

  # POST /signalements or /signalements.json
  def create
    @signalement = Signalement.new(signalement_params)
    @signalement.administration_id = current_user.administration_id
    @signalement.createur = current_user

    respond_to do |format|
      if @signalement.save
        format.html { redirect_to @signalement, notice: "Signalement créé avec succès !" }
        format.json { render :show, status: :created, location: @signalement }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @signalement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /signalements/1 or /signalements/1.json
  def update
    respond_to do |format|
      if @signalement.update(signalement_params)
        format.html { redirect_to @signalement, notice: "Signalement mis-à-jour avec succès !" }
        format.json { render :show, status: :ok, location: @signalement }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @signalement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /signalements/1 or /signalements/1.json
  def destroy
    @signalement.destroy
    respond_to do |format|
      format.html { redirect_to signalements_url, notice: "Signalement détruit avec succès !" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_signalement
      @signalement = Signalement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def signalement_params
      params.require(:signalement).permit(:urgence, :reference_administration, :commentaire, :lieux_faits, :date_faits, :nataff, :natinf, documents: [])
    end
end
