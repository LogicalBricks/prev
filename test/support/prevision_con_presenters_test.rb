require "test_helper"

class PrevisionConPresentersTest < ActiveSupport::TestCase
  test "#movimientos es el conjunto de gastos, depositos y comisiones" do
    klass = Struct.new(:monto)
    gasto_1 = klass.new(16)
    gasto_presenter_1 = Object.new
    comision_1 = klass.new(16)
    comision_presenter_1 = Object.new
    comision_2 = klass.new(9)
    comision_presenter_2 = Object.new
    deposito_1 = klass.new(21)
    deposito_presenter_1 = Object.new
    deposito_2 = klass.new(11)
    deposito_presenter_2 = Object.new
    deposito_3 = klass.new(14)
    deposito_presenter_3 = Object.new
    gastos = [gasto_1]
    depositos = [deposito_1, deposito_2, deposito_3]
    comisiones = [comision_1, comision_2]
    p = Struct.new(:gastos, :depositos, :comisiones).new(gastos, depositos, comisiones)
    gasto_class = Minitest::Mock.new
    gasto_class.expect :new, gasto_presenter_1, [gasto_1]
    deposito_class = Minitest::Mock.new
    deposito_class.expect :new, deposito_presenter_1, [deposito_1]
    deposito_class.expect :new, deposito_presenter_2, [deposito_2]
    deposito_class.expect :new, deposito_presenter_3, [deposito_3]
    comision_class = Minitest::Mock.new
    comision_class.expect :new, comision_presenter_1, [comision_1]
    comision_class.expect :new, comision_presenter_2, [comision_2]
    prevision = PrevisionConPresenters.new(p, gasto_class: gasto_class, deposito_class: deposito_class, comision_class: comision_class)
    assert_equal 1, prevision.gastos.size
    assert_equal 3, prevision.depositos.size
    assert_equal 2, prevision.comisiones.size
    assert_equal [gasto_presenter_1], prevision.gastos
    assert_equal [deposito_presenter_1, deposito_presenter_2, deposito_presenter_3], prevision.depositos
    assert_equal [comision_presenter_1, comision_presenter_2], prevision.comisiones
  end
end
