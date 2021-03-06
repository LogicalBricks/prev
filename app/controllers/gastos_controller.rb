class GastosController < ApplicationController
  before_action :set_gasto, only: [:show, :edit, :update, :destroy]

  # GET /gastos
  # GET /gastos.json
  def index
    @gastos = Gasto.para_listado(prevision: prevision_activa)
  end

  # GET /gastos/1
  # GET /gastos/1.json
  def show
  end

  # GET /gastos/new
  def new
    @gasto = Gasto.new apartado_id: params[:apartado_id]
  end

  # GET /gastos/1/edit
  def edit
  end

  # POST /gastos
  # POST /gastos.json
  def create
    @gasto = Gasto.new(gasto_params)

    respond_to do |format|
      if @gasto.save
        send_email if socio.monto_cerca_de_limites?(apartado)
        format.html { redirect_to @gasto, notice: 'Gasto guardado correctamente.' }
        format.json { render :show, status: :created, location: @gasto }
      else
        format.html { render :new }
        format.json { render json: @gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gastos/1
  # PATCH/PUT /gastos/1.json
  def update
    respond_to do |format|
      if @gasto.update(gasto_params)
        send_email if @gasto.socio.monto_cerca_de_limites?(@gasto.apartado)
        format.html { redirect_to @gasto, notice: 'Gasto actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @gasto }
      else
        format.html { render :edit }
        format.json { render json: @gasto.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gastos/1
  # DELETE /gastos/1.json
  def destroy
    @gasto.destroy
    respond_to do |format|
      format.html { redirect_to gastos_url, notice: 'Gasto eliminado correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gasto
      @gasto = Gasto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gasto_params
      params.require(:gasto).permit(
        :factura_xml, :factura_pdf, :solicitud, :monto, :fecha, :metodo_pago,
        :descripcion, :socio_id, :proveedor_id, :apartado_id, :iva, :total,
        :descontar_de_reservado, :espera_pago_impuestos,
      )
    end

    def send_email
      MontoCercaDeLimiteMailer.notificacion(socio, apartado).deliver_now
    end

    def socio
      @gasto.socio
    end

    def apartado
      @gasto.apartado
    end
end
