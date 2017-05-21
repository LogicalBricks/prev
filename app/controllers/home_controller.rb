class HomeController < ApplicationController
  def index
    render :no_socio and return if Socio.count == 0
    render :no_rubro and return if Rubro.count == 0
    render :no_prevision and return if Prevision.count == 0
    render :no_prevision_activa and return if Prevision.default.nil?
    render :no_deposito and return if Deposito.count == 0

    @prevision = prevision_activa
  end

  def estado_cuenta
    @mas_iva = params[:mas_iva]
    @estado_cuenta = EstadoCuenta.new(
      movimientos_anteriores: movimientos_anteriores,
      movimientos_en_rango: movimientos_en_rango
    )

    respond_to do |format|
      format.html
      format.xls { send_data(xls_file, filename: 'estado_cuenta.xls') }
    end
  end

private

  def xls_file
    @estado_cuenta.movimientos.to_xls(
      columns: %i[fecha descripcion metodo cargo abono],
      headers: ["Fecha", "Descripción", "Método", "Cargo", "Abono"]
    )
  end

  def movimientos_anteriores
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision,
                                                            rango_fechas.actual)
    MovimientosEstadoCuenta.new(prevision: prevision_presenter,
                                mas_iva: params[:mas_iva])
  end

  def movimientos_en_rango
    prevision_presenter = Prevision::PrevisionPresenter.new(prevision,
                                                            rango_fechas.previo)
    MovimientosEstadoCuenta.new(prevision: prevision_presenter,
                                mas_iva: params[:mas_iva])
  end

  def prevision
    @prevision ||= Prevision.de_periodo(prevision_activa.periodo)
  end

  def rango_fechas
    @rango_fechas ||= RangoFechasEstadoCuenta.new(params[:mes], year)
  end

  def year
    prevision_activa.periodo
  end
end
