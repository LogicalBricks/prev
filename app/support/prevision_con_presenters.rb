class PrevisionConPresenters
  attr_accessor :gasto_presenter, :deposito_presenter, :comision_presenter

  def initialize(prevision, gasto_class: nil, deposito_class: nil, comision_class: nil)
    @prevision = prevision
    @gasto_class = gasto_class || GastoPresenter
    @deposito_class = deposito_class || DepositoPresenter
    @comision_class = comision_class || ComisionPresenter
  end

  def gastos
    @gastos ||= prevision.gastos.map { |c| @gasto_class.new(c) }
  end

  def depositos
    @depositos ||= prevision.depositos.map { |c| @deposito_class.new(c) }
  end

  def comisiones
    @comisiones ||= prevision.comisiones.map { |c| @comision_class.new(c) }
  end

private

  attr_reader :prevision

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
