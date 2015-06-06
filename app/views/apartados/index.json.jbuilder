json.array!(@apartados) do |apartado|
  json.extract! apartado, :id, :monto_maximo, :rubro_id, :prevision_id
  json.url apartado_url(apartado, format: :json)
end
