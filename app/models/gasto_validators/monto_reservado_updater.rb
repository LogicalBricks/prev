module GastoValidators
  class MontoReservadoUpdater
    def initialize(gasto, tope)
      @gasto = gasto
      @tope = tope
    end

    def call
      @tope.update monto_reservado: nuevo_monto
    end

  private

    def nuevo_monto
      @tope.monto_reservado - @gasto.monto
    end
  end
end
