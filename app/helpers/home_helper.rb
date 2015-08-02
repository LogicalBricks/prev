module HomeHelper
  def estado_cuenta(movimientos=@movimientos)
    @estado_cuenta ||= EstadoCuenta.new(movimientos)
  end

  end
end
