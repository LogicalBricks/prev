json.array!(@rubros) do |rubro|
  json.extract! rubro, :id, :nombre, :descripcion
  json.url rubro_url(rubro, format: :json)
end
