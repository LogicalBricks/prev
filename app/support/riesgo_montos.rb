class RiesgoMontos
  class << self
    def build(monto:, monto_limite:)
      Builder.new(monto, monto_limite).build
    end

    def inherited(klass)
      inherited_classes << klass
    end

    def inherited_classes
      @inherited_classes ||= []
    end
  end

  class Builder
    def initialize(monto, monto_limite)
      @monto = monto
      @monto_limite = monto_limite
    end

    def build
      find_riesgo_montos_correspondiente || default_riesgo_montos
    end

    def find_riesgo_montos_correspondiente
      riesgo_montos_objects.find(&:corresponde?)
    end

    def default_riesgo_montos
      RiesgoMontos.new(monto: @monto, monto_limite: @monto_limite)
    end

    def riesgo_montos_objects
      @riesgo_monto_objects ||= inherited_classes.map do |klass|
        klass.new(monto: @monto, monto_limite: @monto_limite)
      end.sort
    end

    def inherited_classes
      RiesgoMontos.inherited_classes
    end
  end

  attr_reader :monto, :monto_limite

  def initialize(monto:, monto_limite:)
    @monto = monto.to_f
    @monto_limite = monto_limite.to_f
  end

  def <=>(other)
    tope_maximo <=> other.tope_maximo
  end

  def corresponde?
    proporcion.between?(tope_minimo, tope_maximo)
  end

  def proporcion
    @proporcion ||= (@monto / @monto_limite) * 100
  end

  def rango
    raise NotImplementedError
  end

  def riesgo
    "generico"
  end

protected

  def tope_maximo
    rango.max
  end

  def tope_minimo
    rango.min
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
