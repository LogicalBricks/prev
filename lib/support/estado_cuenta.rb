class EstadoCuenta
  attr_reader :total_cargos, :total_abonos

  def initialize(movimientos, fechas)
    @movimientos  = movimientos
    @fechas       = fechas
    @total_cargos = @total_abonos = 0.0
  end

  def each
    por_fecha(@movimientos).each do |v|
      @total_cargos += v.cargo.to_f
      @total_abonos += v.abono.to_f
      yield v
    end
  end

  def saldo_a_inicio_fecha
    saldo_por_fecha(movimientos_hasta_fecha_anterior)
  end

  def saldo_a_final_fecha
    saldo_por_fecha(movimientos_hasta_fecha_actual)
  end

  private

  def por_fecha movimientos
    movimientos.select {|m| @fechas.include? m.fecha}
  end

  def movimientos_hasta_fecha_anterior
    @movimientos.select {|m| m.fecha < @fechas.begin}
  end

  def movimientos_hasta_fecha_actual
    @movimientos.select {|m| m.fecha <= @fechas.end}
  end

  def saldo_por_fecha movimientos
    saldo = gasto = 0.0
    movimientos.each do |m|
      saldo += m.cargo.to_f
      gasto += m.abono.to_f
    end
    saldo - gasto
  end
end
