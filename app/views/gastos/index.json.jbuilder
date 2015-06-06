json.array!(@gastos) do |gasto|
  json.extract! gasto, :id, :factura_xml, :factura_pdf, :solicitud, :monto, :fecha, :metodo_pago, :descripcion, :socio_id, :proveedor_id, :apartado_id
  json.url gasto_url(gasto, format: :json)
end
