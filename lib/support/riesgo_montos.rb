class RiesgoMontos
  class << self
    def build(monto:, monto_limite:)
      riesgo_montos_objects(monto: monto, monto_limite: monto_limite).find(&:corresponde?)
    end

    def inherited(klass)
      inherited_classes << klass
    end

    def inherited_classes
      @inherited_classes ||= []
    end

    def riesgo_montos_objects(monto:, monto_limite:)
      inherited_classes.map do |klass|
        klass.new(monto: monto, monto_limite: monto_limite)
      end
    end
  end

  attr_reader :monto, :monto_limite

  def initialize(monto:, monto_limite:)
    @monto = monto.to_f
    @monto_limite = monto_limite.to_f
  end

  def corresponde?
    proporcion >= tope_minimo && proporcion < tope_maximo
  end

  def proporcion
    @proporcion ||= (@monto / @monto_limite) * 100
  end

  def tope_maximo
    rango.max
  end

  def tope_minimo
    rango.min
  end

  def rango
    raise NotImplementedError
  end

  def riesgo
    raise NotImplementedError
  end
end

class RiesgoAltoMontos < RiesgoMontos
  def rango
    80..100
  end

  def riesgo
    "alto"
  end
end

class RiesgoBajoMontos < RiesgoMontos
  def rango
    0..40
  end

  def riesgo
    "bajo"
  end
end

class RiesgoModeradoMontos < RiesgoMontos
  def rango
    40..80
  end

  def riesgo
    "moderado"
  end
end
