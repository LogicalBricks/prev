class EstadoCuenta
  class << self
    def build(prevision: , rango_fechas:, mas_iva:)
      new(movimientos_anteriores: movimientos_anteriores(prevision, rango_fechas, mas_iva),
          movimientos_en_rango: movimientos_en_rango(prevision, rango_fechas, mas_iva))
    end

    def movimientos_anteriores(prevision, rango_fechas, mas_iva)
      presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas.previo)
      gasto_class = mas_iva ? PrevisionConPresenters::GastoConIvaPresenter : PrevisionConPresenters::GastoPresenter
      prevision_con_presenters = PrevisionConPresenters.new(presenter, gasto_class: gasto_class)
      MovimientosEstadoCuenta.new(PrevisionConMovimientos.new(prevision_con_presenters))
    end

    def movimientos_en_rango(prevision, rango_fechas, mas_iva)
      presenter = Prevision::PrevisionPresenter.new(prevision, rango_fechas.actual)
      gasto_class = mas_iva ? PrevisionConPresenters::GastoConIvaPresenter : PrevisionConPresenters::GastoPresenter
      prevision_con_presenters = PrevisionConPresenters.new(presenter, gasto_class: gasto_class)
      MovimientosEstadoCuenta.new(PrevisionConMovimientos.new(prevision_con_presenters))
    end
  end

  def initialize(movimientos_en_rango:, movimientos_anteriores:)
    @movimientos_en_rango = movimientos_en_rango
    @movimientos_anteriores = movimientos_anteriores
  end

  def movimientos
    movimientos_en_rango.to_a
  end

  def total_cargos
    movimientos_en_rango.total_cargos
  end

  def total_abonos
    movimientos_en_rango.total_abonos
  end

  def saldo_inicial
    movimientos_anteriores.total_cargos - movimientos_anteriores.total_abonos
  end

  def saldo_final
    saldo_inicial + total_cargos - total_abonos
  end

  def to_xls
    movimientos.to_xls(
      columns: %i[fecha descripcion metodo cargo abono],
      headers: ["Fecha", "Descripción", "Método", "Cargo", "Abono"]
    )
  end

private

  attr_reader :movimientos_en_rango, :movimientos_anteriores
end
