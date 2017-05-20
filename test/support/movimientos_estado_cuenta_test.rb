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
    gastos = gastos.map { |gasto| Struct.new(:monto, :iva).new(gasto[:monto], gasto[:iva]) }
    depositos = depositos.map { |deposito| Struct.new(:monto).new(deposito[:monto]) }
    comisiones = comisiones.map { |comision| Struct.new(:monto).new(comision[:monto]) }
    Struct.new(:gastos, :depositos, :comisiones).new(gastos, depositos, comisiones)
  end

  test "#movimientos es el arreglo de gastos que responden a cargo y abono (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false).to_a
    assert_cargos([nil, nil, 2, 9, 8, nil], movimientos)
    assert_abonos([10, 3, nil, nil, nil, 1], movimientos)
  end

  test "#movimientos es el arreglo de gastos que responden a cargo y abono (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true).to_a
    assert_cargos([nil, nil, 2, 9, 8, nil], movimientos)
    assert_abonos([11.6, 3.48, nil, nil, nil, 1], movimientos)
  end

  test "#total_cargos es la suma de cargos (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (sin iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: false)
    assert_equal 14, movimientos.total_abonos
  end

  test "#total_cargos es la suma de cargos (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true)
    assert_equal 19, movimientos.total_cargos
  end

  test "#total_abonos es la suma de abonos (con iva)" do
    prevision = create_prevision(
      gastos: [{ monto: 10, iva: 1.6 }, { monto: 3, iva: 0.48 }],
      depositos: [{ monto: 2 }, { monto: 9 }, { monto: 8 }],
      comisiones: [{ monto: 1 }]
    )
    movimientos = MovimientosEstadoCuenta.new(prevision: prevision, mas_iva: true)
    assert_equal 16.08, movimientos.total_abonos
  end
end
