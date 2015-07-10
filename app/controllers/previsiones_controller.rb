class PrevisionesController < ApplicationController
  before_action :set_prevision, only: [:show, :edit, :update, :destroy]

  # GET /previsiones
  # GET /previsiones.json
  def index
    @previsiones = Prevision.all
  end

  # GET /previsiones/1
  # GET /previsiones/1.json
  def show
    @prevision = Prevision.includes(topes: :socio, apartados: :rubro).find(params[:id])
  end

  # GET /previsiones/new
  def new
    @prevision = Prevision.new
    @prevision.topes.build
    @prevision.apartados.build
  end

  # GET /previsiones/1/edit
  def edit
  end

  # POST /previsiones
  # POST /previsiones.json
  def create
    @prevision = Prevision.new(prevision_params)

    respond_to do |format|
      if @prevision.save
        format.html { redirect_to @prevision, notice: 'Previsión guardada correctamente.' }
        format.json { render :show, status: :created, location: @prevision }
      else
        format.html { render :new }
        format.json { render json: @prevision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /previsiones/1
  # PATCH/PUT /previsiones/1.json
  def update
    respond_to do |format|
      if @prevision.update(prevision_params)
        format.html { redirect_to @prevision, notice: 'Previsión actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @prevision }
      else
        format.html { render :edit }
        format.json { render json: @prevision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /previsiones/1
  # DELETE /previsiones/1.json
  def destroy
    @prevision.destroy
    respond_to do |format|
      format.html { redirect_to previsiones_url, notice: 'Previsión eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prevision
      @prevision = Prevision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prevision_params
      params.require(:prevision).permit(
        :periodo,
        :monto_remanente,
        :monto_presupuestado,
        apartados_attributes: [:id, :rubro_id, :monto_maximo, :_destroy],
        topes_attributes: [:id, :socio_id, :monto, :_destroy]
      )
    end
end
