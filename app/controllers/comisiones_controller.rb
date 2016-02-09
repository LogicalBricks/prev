class ComisionesController < ApplicationController
  before_action :set_comision, only: [:show, :edit, :update, :destroy]

  # GET /comisiones
  # GET /comisiones.json
  def index
    @comisiones = Comision.para_listar
  end

  # GET /comisiones/1
  # GET /comisiones/1.json
  def show
  end

  # GET /comisiones/new
  def new
    @comision = Comision.new prevision: Prevision.activa
  end

  # GET /comisiones/1/edit
  def edit
  end

  # POST /comisiones
  # POST /comisiones.json
  def create
    @comision = Comision.new(comision_params)

    respond_to do |format|
      if @comision.save
        format.html { redirect_to @comision, notice: 'Comisión guardada correctamente.' }
        format.json { render :show, status: :created, location: @comision }
      else
        format.html { render :new }
        format.json { render json: @comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comisiones/1
  # PATCH/PUT /comisiones/1.json
  def update
    respond_to do |format|
      if @comision.update(comision_params)
        format.html { redirect_to @comision, notice: 'Comisión actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @comision }
      else
        format.html { render :edit }
        format.json { render json: @comision.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comisiones/1
  # DELETE /comisiones/1.json
  def destroy
    @comision.destroy
    respond_to do |format|
      format.html { redirect_to comisiones_url, notice: 'Comisión eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comision
      @comision = Comision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comision_params
      params.require(:comision).permit(:monto, :descripcion, :fecha, :prevision_id, :fecha_reposicion, :comentario)
    end
end
