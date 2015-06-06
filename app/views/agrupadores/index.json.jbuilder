json.array!(@agrupadores) do |agrupador|
  json.extract! agrupador, :id, :nombre
  json.url agrupador_url(agrupador, format: :json)
end
