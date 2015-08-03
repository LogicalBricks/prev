module HomeHelper
  def estado_cuenta(movimientos=@movimientos)
    @estado_cuenta ||= EstadoCuenta.new(movimientos)
  end

  def mostrar_montos(monto:, monto_limite:)
    str = ""
    str = span_tag(monto.to_f, monto_limite.to_f)
    str << " / "
    str << number_to_currency(monto_limite)
    str
  end

  def span_tag(monto, monto_limite)
    if monto / monto_limite >= 0.8
      add_class('alto', monto)
    elsif monto / monto_limite >= 0.4
      add_class('moderado', monto)
    else
      add_class('bajo', monto)
    end
  end

  def add_class(css_class, monto)
    content_tag :span, class: "riesgo-#{css_class}" do
      number_to_currency(monto)
    end
  end
end
