require "test_helper"

class PrevisionConMovimientosTest < ActiveSupport::TestCase
  test "#movimientos returns all the gastos, comisiones and depositos ordered by fecha" do
    gasto_1 = Struct.new(:fecha).new(Time.current)
    gasto_2 = Struct.new(:fecha).new(1.day.from_now)
    gastos = [gasto_1, gasto_2]
    deposito_1 = Struct.new(:fecha).new(1.day.ago)
    deposito_2 = Struct.new(:fecha).new(1.minute.ago)
    deposito_3 = Struct.new(:fecha).new(1.minute.from_now)
    depositos = [deposito_1, deposito_2, deposito_3]
    comision_1 = Struct.new(:fecha).new(2.minutes.ago)
    comisiones = [comision_1]
    prevision_con_presenters = Struct.new(:gastos, :depositos, :comisiones).new(gastos, depositos, comisiones)
    prevision = PrevisionConMovimientos.new(prevision_con_presenters)
    movimientos_ordenados = [deposito_1, comision_1, deposito_2, gasto_1, deposito_3, gasto_2]
    assert_equal movimientos_ordenados, prevision.movimientos
  end
end
