module HomeHelper
  def mostrar_montos(monto:, monto_limite:, ocultar_limite: false)
    riesgo_montos = RiesgoMontos.build monto: monto, monto_limite: monto_limite
    if ocultar_limite
      mostrar_monto(riesgo_montos)
    else
      mostrar_monto(riesgo_montos) + mostrar_monto_limite(riesgo_montos)
    end
  end

  def mostrar_monto(riesgo_montos)
    content_tag :span, class: "riesgo-#{riesgo_montos.riesgo}" do
      number_to_currency(riesgo_montos.monto)
    end
  end

  def mostrar_monto_limite(riesgo_montos)
    " / " + number_to_currency(riesgo_montos.monto_limite)
  end
end
