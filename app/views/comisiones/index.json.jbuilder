json.array!(@comisiones) do |comision|
  json.extract! comision, :id, :monto, :descripcion, :fecha, :prevision_id
  json.url comision_url(comision, format: :json)
end
