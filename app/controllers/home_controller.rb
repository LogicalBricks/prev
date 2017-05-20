class HomeController < ApplicationController
  NOMBRES_MESES = Date::MONTHNAMES.map { |x| x.nil? ? x : I18n.l(Date.parse(x), format: "%B").capitalize }

  def index
    render :no_socio and return if Socio.count == 0
    render :no_rubro and return if Rubro.count == 0
    render :no_prevision and return if Prevision.count == 0
    render :no_prevision_activa and return if Prevision.default.nil?
    render :no_deposito and return if Deposito.count == 0

    @prevision = prevision_activa
  end

  def estado_cuenta
    prevision    = Prevision.de_periodo(prevision_activa.periodo)
    prevision1    = Prevision::PrevisionPresenter.new(prevision, calcula_fechas)
    movimientos1 = MovimientosEstadoCuenta.new(prevision: prevision1, mas_iva: params[:mas_iva])
    prevision2    = Prevision::PrevisionPresenter.new(prevision, calcula_fechas)
    movimientos2 = MovimientosEstadoCuenta.new(prevision: prevision2, mas_iva: params[:mas_iva])
    @estado_cuenta = EstadoCuenta.new(movimientos_anteriores: movimientos1, movimientos_en_rango: movimientos2)

    respond_to do |format|
      format.html
      format.xls { send_data(xls_file, filename: 'estado_cuenta.xls') }
    end
  end

private

  def calcula_fechas
    mes = parse_month.to_i
    if mes != 0
      fecha = Date.new(prevision_activa.periodo.to_i, mes)
      fecha.beginning_of_month..fecha.end_of_month
    else
      fecha = Date.new(prevision_activa.periodo.to_i)
      fecha.beginning_of_year..fecha.end_of_year
    end
  end

  def xls_file
    @estado_cuenta.movimientos.to_xls(
      columns: %i[fecha descripcion metodo cargo abono],
      headers: ["Fecha", "Descripción", "Método", "Cargo", "Abono"]
    )
  end

  def parse_month
    Date.parse(english_month_name).month if english_month_name.present?
  rescue ArgumentError => e
    nil
  end

  def english_month_name
    month_index = NOMBRES_MESES.index(params[:mes])
    month_index && Date::MONTHNAMES[month_index]
  end
end
