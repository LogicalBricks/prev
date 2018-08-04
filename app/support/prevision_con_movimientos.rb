class PrevisionConMovimientos
  def initialize(prevision)
    @prevision = prevision
  end

  def movimientos
    @movimientos ||= movimientos_presenter.sort_by(&:fecha)
  end

private

  def movimientos_presenter
    @prevision.gastos + @prevision.comisiones + @prevision.depositos
  end
end
