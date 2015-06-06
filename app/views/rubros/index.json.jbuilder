json.array!(@rubros) do |rubro|
  json.extract! rubro, :id, :nombre, :descripcion, :agrupador_id
  json.url rubro_url(rubro, format: :json)
end
