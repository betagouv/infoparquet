class SignalementsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_signalement, only: %i[ show edit update destroy ]

  # GET /signalements or /signalements.json
  def index
    @signalements = Signalement.all
  end

  # GET /signalements/1 or /signalements/1.json
  def show
  end

  # GET /signalements/new
  def new
    @signalement = Signalement.new
  end

  # GET /signalements/1/edit
  def edit
  end

  # POST /signalements or /signalements.json
  def create
    @signalement = Signalement.new(signalement_params)
    @signalement.demandeur = current_user

    respond_to do |format|
      if @signalement.save
        format.html { redirect_to @signalement, notice: "Signalement was successfully created." }
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
        format.html { redirect_to @signalement, notice: "Signalement was successfully updated." }
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
      format.html { redirect_to signalements_url, notice: "Signalement was successfully destroyed." }
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
      params.require(:signalement).permit(:type_signalement, :urgence, :motif, :reference_administration, :commentaire, :reference_juridiction)
    end
end
