module HomeHelper
  def estado_cuenta(movimientos=@movimientos)
    @estado_cuenta ||= EstadoCuenta.new(movimientos)
  end

  class EstadoCuenta
    attr_reader :total_cargos, :total_abonos

    def initialize(movimientos)
      @movimientos = movimientos
      @total_cargos = @total_abonos = 0.0
    end

    def each
      @movimientos.each do |v|
        @total_cargos += v.cargo.to_f
        @total_abonos += v.abono.to_f
        yield v
      end
    end
  end
end
