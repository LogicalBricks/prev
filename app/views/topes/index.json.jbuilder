json.array!(@topes) do |tope|
  json.extract! tope, :id, :socio, :monto, :prevision_id, :socio_id
  json.url tope_url(tope, format: :json)
end
