require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test 'should format monto and monto_limite' do
    html = '<span class="riesgo-bajo">$10.00</span> / $123.00'
    assert_equal html, mostrar_montos(monto: 10, monto_limite: 123.0)

    html = '<span class="riesgo-bajo">$11.00</span> / $321.00'
    assert_equal html, mostrar_montos(monto: 11, monto_limite: 321)
  end

  test 'should add red color to monto if it is close to monto_limite' do
    html = '<span class="riesgo-alto">$120.00</span> / $123.00'
    assert_equal html, mostrar_montos(monto: 120.0, monto_limite: 123)

    html = '<span class="riesgo-alto">$80.00</span> / $100.00'
    assert_equal html, mostrar_montos(monto: 80, monto_limite: 100)
  end

  test 'should add orange color to monto if it is about 50% of monto_limite' do
    html = '<span class="riesgo-moderado">$40.00</span> / $100.00'
    assert_equal html, mostrar_montos(monto: 40.0, monto_limite: 100)

    html = '<span class="riesgo-moderado">$79.99</span> / $100.00'
    assert_equal html, mostrar_montos(monto: 79.99, monto_limite: 100)
  end
end
