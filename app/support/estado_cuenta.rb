class EstadoCuenta
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

private

  attr_reader :movimientos_en_rango, :movimientos_anteriores
end
