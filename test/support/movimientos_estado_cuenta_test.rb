require "test_helper"

class MovimientosEstadoCuentaTest < ActiveSupport::TestCase
  test "#to_a es el arreglo de gastos ordenados por fecha" do
    movimiento_1 = Struct.new(:cargo, :abono, :fecha).new(2, nil, 5.weeks.ago)
    movimiento_2 = Struct.new(:cargo, :abono, :fecha).new(nil, 10, 1.month.ago)
    movimiento_3 = Struct.new(:cargo, :abono, :fecha).new(4, nil, 1.month.ago)
    movimiento_4 = Struct.new(:cargo, :abono, :fecha).new(nil, 2, 4.days.ago)
    prevision = Struct.new(:movimientos).new([movimiento_1, movimiento_2, movimiento_3, movimiento_4])
    movimientos = MovimientosEstadoCuenta.new(prevision)
    assert [movimiento_3, movimiento_4, movimiento_2, movimiento_1], movimientos.to_a
  end

  test "#total_cargos es la suma de cargos" do
    movimiento_1 = Struct.new(:cargo, :abono, :fecha).new(2, nil, 5.weeks.ago)
    movimiento_2 = Struct.new(:cargo, :abono, :fecha).new(nil, 10, 1.month.ago)
    movimiento_3 = Struct.new(:cargo, :abono, :fecha).new(4, nil, 1.month.ago)
    movimiento_4 = Struct.new(:cargo, :abono, :fecha).new(nil, 2, 4.days.ago)
    prevision = Struct.new(:movimientos).new([movimiento_1, movimiento_2, movimiento_3, movimiento_4])
    movimientos = MovimientosEstadoCuenta.new(prevision)
    assert 7, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos" do
    movimiento_1 = Struct.new(:cargo, :abono, :fecha).new(2, nil, 5.weeks.ago)
    movimiento_2 = Struct.new(:cargo, :abono, :fecha).new(nil, 10, 1.month.ago)
    movimiento_3 = Struct.new(:cargo, :abono, :fecha).new(4, nil, 1.month.ago)
    movimiento_4 = Struct.new(:cargo, :abono, :fecha).new(nil, 2, 4.days.ago)
    prevision = Struct.new(:movimientos).new([movimiento_1, movimiento_2, movimiento_3, movimiento_4])
    movimientos = MovimientosEstadoCuenta.new(prevision)
    assert 12, movimientos.total_abonos
  end
end
