json.array!(@socios) do |socio|
  json.extract! socio, :id, :nombre, :usuario_id
  json.url socio_url(socio, format: :json)
end
