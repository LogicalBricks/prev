class MovimientosEstadoCuenta
  def initialize(prevision)
    @prevision = prevision
  end

  def to_a
    movimientos.sort_by(&:fecha)
  end

  def total_cargos
    to_a.map(&:cargo).compact.sum
  end

  def total_abonos
    to_a.map(&:abono).compact.sum
  end

private

  attr_reader :prevision

  def movimientos
    prevision.movimientos
  end
end
