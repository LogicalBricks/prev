module HomeHelper
  def estado_cuenta(movimientos=@movimientos)
    @estado_cuenta ||= EstadoCuenta.new(movimientos)
  end

  def mostrar_montos(monto:, monto_limite:)
    riesgo_montos = RiesgoMontos.build monto: monto, monto_limite: monto_limite
    add_class(riesgo_montos) + " / " + number_to_currency(monto_limite)
  end

  def add_class(riesgo_montos)
    content_tag :span, class: "riesgo-#{riesgo_montos.riesgo}" do
      number_to_currency(riesgo_montos.monto)
    end
  end
end
