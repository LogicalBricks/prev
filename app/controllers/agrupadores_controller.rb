class AgrupadoresController < ApplicationController
  before_action :set_agrupador, only: [:show, :edit, :update, :destroy]

  # GET /agrupadores
  # GET /agrupadores.json
  def index
    @agrupadores = Agrupador.all
  end

  # GET /agrupadores/1
  # GET /agrupadores/1.json
  def show
  end

  # GET /agrupadores/new
  def new
    @agrupador = Agrupador.new
  end

  # GET /agrupadores/1/edit
  def edit
  end

  # POST /agrupadores
  # POST /agrupadores.json
  def create
    @agrupador = Agrupador.new(agrupador_params)

    respond_to do |format|
      if @agrupador.save
        format.html { redirect_to @agrupador, notice: 'Agrupador was successfully created.' }
        format.json { render :show, status: :created, location: @agrupador }
      else
        format.html { render :new }
        format.json { render json: @agrupador.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /agrupadores/1
  # PATCH/PUT /agrupadores/1.json
  def update
    respond_to do |format|
      if @agrupador.update(agrupador_params)
        format.html { redirect_to @agrupador, notice: 'Agrupador was successfully updated.' }
        format.json { render :show, status: :ok, location: @agrupador }
      else
        format.html { render :edit }
        format.json { render json: @agrupador.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /agrupadores/1
  # DELETE /agrupadores/1.json
  def destroy
    @agrupador.destroy
    respond_to do |format|
      format.html { redirect_to agrupadores_url, notice: 'Agrupador was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agrupador
      @agrupador = Agrupador.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def agrupador_params
      params.require(:agrupador).permit(:nombre)
    end
end
