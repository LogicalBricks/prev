require "test_helper"

class RangoFechasEstadoCuentaTest < Minitest::Test
  def test_actual_is_the_range_of_january_2017
    rango = RangoFechasEstadoCuenta.new("Enero", 2017)
    fecha1 = "2017/1/1".to_date
    fecha2 = "2017/1/31".to_date
    assert_equal fecha1..fecha2, rango.actual
  end

  def test_actual_is_the_range_of_april_2016
    rango = RangoFechasEstadoCuenta.new("Abril", 2016)
    fecha1 = "2016/4/1".to_date
    fecha2 = "2016/4/30".to_date
    assert_equal fecha1..fecha2, rango.actual
  end

  def test_actual_is_the_whole_year
    rango = RangoFechasEstadoCuenta.new(nil, 2016)
    fecha1 = "2016/1/1".to_date
    fecha2 = "2016/12/31".to_date
    assert_equal fecha1..fecha2, rango.actual
  end

  def test_previo_is_the_range_of_january_july_2017
    rango = RangoFechasEstadoCuenta.new("Agosto", 2017)
    fecha1 = "2017/1/1".to_date
    fecha2 = "2017/7/31".to_date
    assert_equal fecha1..fecha2, rango.previo
  end

  def test_previo_is_the_range_of_january_october_2016
    rango = RangoFechasEstadoCuenta.new("Noviembre", 2016)
    fecha1 = "2016/1/1".to_date
    fecha2 = "2016/10/31".to_date
    assert_equal fecha1..fecha2, rango.previo
  end

  def test_previo_is_nil
    rango = RangoFechasEstadoCuenta.new("", 2016)
    fecha1 = "2016/1/1".to_date
    fecha2 = "2016/12/31".to_date
    assert_nil rango.previo
  end
end
