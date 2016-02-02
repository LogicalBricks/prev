class PrevisionActiva
  def initialize(prevision)
    @prevision = prevision
  end

  def activar
    prevision_anterior.update activa: false if prevision_anterior
    prevision.update activa: true
  end

private

  attr_reader :prevision

  def prevision_anterior
    Prevision.activa
  end
end
