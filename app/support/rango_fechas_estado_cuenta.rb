class RangoFechasEstadoCuenta
  NOMBRES_MESES = Date::MONTHNAMES.map { |x| x.nil? ? x : I18n.l(Date.parse(x), format: "%B").capitalize }

  def initialize(spanish_month_name, year)
    @year  = year.to_i
    @month = convert_month(spanish_month_name)
  end

  def actual
    if month == 0
      fecha_inicio_anio..fecha_fin_anio
    else
      fecha_inicio_mes..fecha_fin_mes
    end
  end

  def previo
    if month != 0
      fecha_inicio_anio..fecha_fin_mes_anterior
    end
  end

private

  attr_accessor :month, :year

  def fecha_inicio_anio
    Date.new(year).beginning_of_year
  end

  def fecha_fin_anio
    Date.new(year).end_of_year
  end

  def fecha_inicio_mes
    Date.new(year, month).beginning_of_month
  end

  def fecha_fin_mes
    Date.new(year, month).end_of_month
  end

  def fecha_fin_mes_anterior
    Date.new(year, month).last_month.end_of_month
  end

  def convert_month(spanish_month_name)
    NOMBRES_MESES.index(spanish_month_name).to_i
  end
end
