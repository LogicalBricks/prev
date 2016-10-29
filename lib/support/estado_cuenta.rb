class EstadoCuenta
  attr_reader :total_cargos, :total_abonos

  def initialize(movimientos, mes)
    @movimientos        = movimientos
    @mes                = mes
    @movimientos_fecha  = por_fecha(movimientos)
    @total_cargos       = @total_abonos = 0.0
  end

  def each
    @movimientos_fecha.each do |v|
      @total_cargos += v.cargo.to_f
      @total_abonos += v.abono.to_f
      yield v
    end
  end

  def saldo_a_inicio_mes
    saldo_por_fecha(movimientos_hasta_fecha_anterior)
  end

  def saldo_a_final_mes
    saldo_por_fecha(movimientos_hasta_fecha_actual)
  end

  def por_mes?
    @mes and @mes != 0
  end

  private

  def por_fecha movimientos
    if por_mes?
      movimientos.select {|m| m.fecha.month == @mes }
    else
      movimientos
    end
  end

  def movimientos_hasta_fecha_anterior
    @movimientos.select {|m| m.fecha.month < @mes}
  end

  def movimientos_hasta_fecha_actual
    @movimientos.select {|m| m.fecha.month <= @mes}
  end

  def saldo_por_fecha movimientos
    saldo_actual = gasto_actual = 0.0
    movimientos.each do |m|
      saldo_actual += m.cargo.to_f
      gasto_actual += (m.abono.to_f + m.impuesto.to_f)
    end
    saldo_actual - gasto_actual
  end
end
