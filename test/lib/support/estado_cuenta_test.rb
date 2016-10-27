require 'test_helper'

class EstadoCuentaTest < Minitest::Test
  def test_saldo__month_january

    deposito_january   = Struct.new(:abono, :cargo, :impuesto, :fecha).new   0,  500,  0, '2016-01-01'.to_date
    gasto_january      = Struct.new(:abono, :cargo, :impuesto, :fecha).new 200,    0, 32, '2016-01-05'.to_date
    gasto_dos_january  = Struct.new(:abono, :cargo, :impuesto, :fecha).new 100,    0, 16, '2016-01-08'.to_date

    months = {'january': 1}
    movimientos   = [deposito_january, gasto_january, gasto_dos_january] 
    estado_cuenta = EstadoCuenta.new movimientos, months[:january]

    assert_equal 0.0, estado_cuenta.saldo_a_inicio_mes
    assert_equal 152, estado_cuenta.saldo_a_final_mes
  end

  def test_saldo_month_february

    deposito_january    = Struct.new(:abono, :cargo, :impuesto, :fecha).new   0, 500, 0, '2016-01-01'.to_date
    gasto_january       = Struct.new(:abono, :cargo, :impuesto, :fecha).new 200,   0, 0, '2016-01-05'.to_date
    gasto_dos_january   = Struct.new(:abono, :cargo, :impuesto, :fecha).new 100,   0, 0, '2016-01-08'.to_date

    deposito_february   = Struct.new(:abono, :cargo, :impuesto, :fecha).new   0, 500, 0, '2016-02-01'.to_date
    gasto_february      = Struct.new(:abono, :cargo, :impuesto, :fecha).new 300,   0, 0, '2016-02-05'.to_date
    gasto_dos_february  = Struct.new(:abono, :cargo, :impuesto, :fecha).new 100,   0, 0, '2016-02-08'.to_date

    months = {'january': 1, 'february': 2}
    movimientos   = [deposito_january, gasto_january, gasto_dos_january, deposito_february, gasto_february, gasto_dos_february] 
    estado_cuenta = EstadoCuenta.new movimientos, months[:february]

    assert_equal 200, estado_cuenta.saldo_a_inicio_mes
    assert_equal 300, estado_cuenta.saldo_a_final_mes
  end
end
