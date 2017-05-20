require "test_helper"

module Minitest::Assertions
  def assert_gastos(abonos, movimientos)
    movimientos = [movimientos] unless movimientos.kind_of?(Array)
    [*abonos[:abonos]].zip(Array(movimientos)).all? do |monto, movimiento|
      assert_equal monto, movimiento.abono
      assert_nil movimiento.cargo
    end
  end

  def assert_depositos(cargos, movimientos)
    movimientos = [movimientos] unless movimientos.kind_of?(Array)
    [*cargos[:cargos]].zip(Array(movimientos)).all? do |monto, movimiento|
      assert_equal monto, movimiento.cargo
      assert_nil movimiento.abono
    end
  end

  def assert_comisiones(abonos, movimientos)
    movimientos = [movimientos] unless movimientos.kind_of?(Array)
    [*abonos[:abonos]].zip(Array(movimientos)).all? do |monto, movimiento|
      assert_equal monto, movimiento.abono
      assert_nil movimiento.cargo
    end
  end
end

class MovimientosEstadoCuentaTest < ActiveSupport::TestCase
  def create_prevision(gastos:, depositos:, comisiones:)
    gastos = gastos.map { |gasto| Struct.new(:monto, :iva).new(gasto[:monto], gasto[:iva]) }
    depositos = depositos.map { |deposito| Struct.new(:monto).new(deposito[:monto]) }
    comisiones = comisiones.map { |comision| Struct.new(:monto).new(comision[:monto]) }
    Struct.new(:gastos, :depositos, :comisiones).new(gastos, depositos, comisiones)
  end

  def setup
    @prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
  end

  test "#movimientos es el arreglo de gastos que responden a cargo y abono (sin iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: false).to_a
    assert_equal 6, movimientos.size
    assert_gastos({ abonos: [10, 3] }, movimientos[0, 2])
    assert_depositos({ cargos: [2, 9, 8] }, movimientos[2, 3])
    assert_comisiones({ abonos: [1] }, movimientos[5])
  end

  test "#movimientos es el arreglo de gastos que responden a cargo y abono (con iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: true).to_a
    assert_equal 6, movimientos.size
    assert_gastos({ abonos: [11.6, 3.48] }, movimientos[0, 2])
    assert_depositos({ cargos: [2, 9, 8] }, movimientos[2, 3])
    assert_comisiones({ abonos: [1] }, movimientos[5])
  end

  test "#total_cargos es la suma de cargos (sin iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: false)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (sin iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: false)
    assert_equal 14, movimientos.total_abonos
  end

  test "#total_cargos es la suma de cargos (con iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: true)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (con iva)" do
    movimientos = MovimientosEstadoCuenta.new(prevision: @prevision, mas_iva: true)
    assert_equal 16.08, movimientos.total_abonos
  end
end
