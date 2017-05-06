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
    @prevision   = Prevision.de_periodo(prevision_activa.periodo)
    @mas_iva     = params[:mas_iva]
    @movimientos = movimientos
    @fechas      = calcula_fechas

    respond_to do |format|
      format.html
      format.xls { send_data(xls_file, filename: 'estado_cuenta.xls') }
    end
  end

private

  def calcula_fechas
    @mes = parse_month.to_i
    if @mes != 0
      fecha = Date.new(prevision_activa.periodo.to_i, @mes)
      fecha.beginning_of_month..fecha.end_of_month
    else
      fecha = Date.new(prevision_activa.periodo.to_i)
      fecha.beginning_of_year..fecha.end_of_year
    end
  end

  def xls_file
    @movimientos.to_xls(
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

  def movimientos
    (depositos + (@mas_iva ? gastos_con_iva : gastos) + comisiones).sort_by(&:fecha)
  end

  def depositos
    @prevision.depositos.map{|d| DepositoPresenter.new(d) }
  end

  def gastos
    @prevision.gastos.includes(:socio, apartado: :rubro).map{|g| GastoPresenter.new(g) }
  end

  def gastos_con_iva
    @prevision.gastos.includes(:socio, apartado: :rubro).map{|g| GastoConIvaPresenter.new(g) }
  end

  def comisiones
    @prevision.comisiones.map{|c| ComisionPresenter.new(c) }
  end

  module MovimientoPresenter
    def cargo; end
    def abono; end
    def metodo; end

    def tipo
      model_name.human
    end

  end

  class DepositoPresenter < SimpleDelegator
    include MovimientoPresenter

    def cargo
      monto
    end
  end

  class GastoPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto
    end

    def descripcion
      "#{apartado.rubro} - #{socio}"
    end

    def metodo
      metodo_pago.capitalize
    end
  end

  class GastoConIvaPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto.to_f + iva.to_f
    end

    def descripcion
      "#{apartado.rubro} - #{socio}"
    end

    def metodo
      metodo_pago.capitalize
    end
  end

  class ComisionPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto
    end
  end

end
