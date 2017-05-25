require "test_helper"

module Minitest::Assertions
  def assert_cargos(cargos, movimientos)
    movimientos = [movimientos] unless movimientos.kind_of?(Array)
    cargos = [cargos] unless cargos.kind_of?(Array)
    cargos.zip(movimientos).all? do |cargo, movimiento|
      if cargo.nil?
        assert_nil movimiento.cargo
      else
        assert_equal cargo, movimiento.cargo
      end
    end
  end

  def assert_abonos(abonos, movimientos)
    movimientos = [movimientos] unless movimientos.kind_of?(Array)
    abonos = [abonos] unless abonos.kind_of?(Array)
    abonos.zip(movimientos).all? do |abono, movimiento|
      if abono.nil?
        assert_nil movimiento.abono
      else
        assert_equal abono, movimiento.abono
      end
    end
  end
end

class MovimientosEstadoCuentaTest < ActiveSupport::TestCase
  def create_prevision(gastos:, depositos:, comisiones:)
    gastos = gastos.map { |gasto| Struct.new(:monto, :iva, :fecha).new(gasto[:monto], gasto[:iva], gasto[:fecha]) }
    depositos = depositos.map { |deposito| Struct.new(:monto, :fecha).new(deposito[:monto], deposito[:fecha]) }
    comisiones = comisiones.map { |comision| Struct.new(:monto, :fecha).new(comision[:monto], comision[:fecha]) }
    Struct.new(:gastos, :depositos, :comisiones).new(gastos, depositos, comisiones)
  end

  test "#to_a es el arreglo de gastos ordenados por fecha que responden a cargo y abono (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false).to_a
    assert_cargos([8, 2, nil, 9, nil, nil], movimientos)
    assert_abonos([nil, nil, 1, nil, 3, 10], movimientos)
  end

  test "#to_a es el arreglo de gastos ordenados por fecha que responden a cargo y abono (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true).to_a
    assert_cargos([8, 2, nil, 9, nil, nil], movimientos)
    assert_abonos([nil, nil, 1, nil, 3.48, 11.6], movimientos)
  end

  test "#total_cargos es la suma de cargos (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false)
    assert_equal 14, movimientos.total_abonos
  end

  test "#total_cargos es la suma de cargos (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6, fecha: 1.day.ago }, { monto: 3, iva: 0.48, fecha: 3.days.ago }],
      depositos: [{ monto: 2, fecha: 1.month.ago }, { monto: 9, fecha: 4.days.ago }, { monto: 8, fecha: 2.months.ago }],
      comisiones: [{ monto: 1, fecha: 1.week.ago }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true)
    assert_equal 16.08, movimientos.total_abonos
  end
end
