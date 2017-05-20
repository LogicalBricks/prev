class MovimientosEstadoCuenta
  def initialize(prevision:, mas_iva:)
    @prevision = prevision
    @mas_iva = mas_iva
  end

  def to_a
    gastos + depositos + comisiones
  end

  def total_cargos
    to_a.map(&:cargo).compact.sum
  end

  def total_abonos
    to_a.map(&:abono).compact.sum
  end

private

  attr_reader :prevision

  def gastos
    presenter = mas_iva? ? GastoConIvaPresenter : GastoPresenter
    prevision.gastos.map { |g| presenter.new(g) }
  end

  def depositos
    prevision.depositos.map { |d| DepositoPresenter.new(d) }
  end

  def comisiones
    prevision.comisiones.map { |c| ComisionPresenter.new(c) }
  end

  def mas_iva?
    !!@mas_iva
  end

  module MovimientoPresenter
    def cargo; end
    def abono; end
    def metodo; end

    def tipo
      model_name.human
    end

  end

  class DepositoPresenter < SimpleDelegator
    include MovimientoPresenter

    def cargo
      monto
    end
  end

  class GastoPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto
    end

    def descripcion
      "#{apartado.rubro} - #{socio}"
    end

    def metodo
      metodo_pago.capitalize
    end
  end

  class GastoConIvaPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto.to_f + iva.to_f
    end

    def descripcion
      "#{apartado.rubro} - #{socio}"
    end

    def metodo
      metodo_pago.capitalize
    end
  end

  class ComisionPresenter < SimpleDelegator
    include MovimientoPresenter

    def abono
      monto
    end
  end
end
