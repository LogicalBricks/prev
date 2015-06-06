json.array!(@depositos) do |deposito|
  json.extract! deposito, :id, :monto, :fecha, :descripcion, :prevision_id
  json.url deposito_url(deposito, format: :json)
end
