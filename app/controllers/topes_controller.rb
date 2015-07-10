class TopesController < ApplicationController
  before_action :set_tope, only: [:show, :edit, :update, :destroy]

  # GET /topes
  # GET /topes.json
  def index
    @topes = Tope.all
  end

  # GET /topes/1
  # GET /topes/1.json
  def show
  end

  # GET /topes/new
  def new
    @tope = Tope.new
  end

  # GET /topes/1/edit
  def edit
  end

  # POST /topes
  # POST /topes.json
  def create
    @tope = Tope.new(tope_params)

    respond_to do |format|
      if @tope.save
        format.html { redirect_to @tope, notice: 'Tope guardado correctamente.' }
        format.json { render :show, status: :created, location: @tope }
      else
        format.html { render :new }
        format.json { render json: @tope.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /topes/1
  # PATCH/PUT /topes/1.json
  def update
    respond_to do |format|
      if @tope.update(tope_params)
        format.html { redirect_to @tope, notice: 'Tope actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @tope }
      else
        format.html { render :edit }
        format.json { render json: @tope.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topes/1
  # DELETE /topes/1.json
  def destroy
    @tope.destroy
    respond_to do |format|
      format.html { redirect_to topes_url, notice: 'Tope eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tope
      @tope = Tope.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tope_params
      params.require(:tope).permit(:monto, :prevision_id, :socio_id)
    end
end
