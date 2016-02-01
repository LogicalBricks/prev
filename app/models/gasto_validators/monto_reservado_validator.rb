module GastoValidators
  class MontoReservadoValidator
    def initialize(gasto)
      @gasto = gasto
    end

    def valid?
      @gasto.monto <= @gasto.socio_monto_reservado
    end
  end
end
