require "test_helper"

class EstadoCuentaTest < ActiveSupport::TestCase
  test "#movimientos regresa movimientos_en_rango.movimientos" do
    movimientos_anteriores = nil
    object1 = Object.new
    object2 = Object.new
    movimientos_en_rango = Struct.new(:to_a).new([object1, object2])
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal [object1, object2], estado_cuenta.movimientos

    movimientos_en_rango = Struct.new(:to_a).new([])
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal [], estado_cuenta.movimientos
  end

  test "#total_cargos regresa el valor de total_cargos de movimientos_en_rango" do
    movimientos_anteriores = nil
    movimientos_en_rango = Struct.new(:total_cargos).new(4)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 4, estado_cuenta.total_cargos

    movimientos_en_rango = Struct.new(:total_cargos).new(2)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 2, estado_cuenta.total_cargos
  end

  test "#total_abonos regresa el valor de total_abonos de movimientos_en_rango" do
    movimientos_anteriores = nil
    movimientos_en_rango = Struct.new(:total_abonos).new(4)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 4, estado_cuenta.total_abonos

    movimientos_en_rango = Struct.new(:total_abonos).new(2)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 2, estado_cuenta.total_abonos
  end

  test "#saldo_inicial es el total de cargos menos total de abonos de los movimientos anteriores " do
    movimientos_anteriores = Struct.new(:total_cargos, :total_abonos).new(3, 1)
    movimientos_en_rango = nil
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 2, estado_cuenta.saldo_inicial

    movimientos_anteriores = Struct.new(:total_cargos, :total_abonos).new(13, 6)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 7, estado_cuenta.saldo_inicial
  end

  test "#saldo_final es el total de cargos menos el total de abonos de los dos movimientos" do
    movimientos_anteriores = Struct.new(:total_cargos, :total_abonos).new(3, 1)
    movimientos_en_rango = Struct.new(:total_cargos, :total_abonos).new(8, 3)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 7, estado_cuenta.saldo_final

    movimientos_anteriores = Struct.new(:total_cargos, :total_abonos).new(6, 2)
    movimientos_en_rango = Struct.new(:total_cargos, :total_abonos).new(16, 7)
    estado_cuenta = EstadoCuenta.new(movimientos_en_rango: movimientos_en_rango,
                                     movimientos_anteriores: movimientos_anteriores)
    assert_equal 13, estado_cuenta.saldo_final
  end
end
