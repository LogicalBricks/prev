json.array!(@previsiones) do |prevision|
  json.extract! prevision, :id, :fecha_inicial, :fecha_final, :monto
  json.url prevision_url(prevision, format: :json)
end
