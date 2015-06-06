json.array!(@proveedores) do |proveedor|
  json.extract! proveedor, :id, :nombre, :rfc
  json.url proveedor_url(proveedor, format: :json)
end
