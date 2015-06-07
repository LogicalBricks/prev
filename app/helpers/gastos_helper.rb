module GastosHelper
  def link_to_file objeto, metodo
    if objeto.send "#{ metodo }?"
      link_to objeto.send(metodo).url, class: 'btn btn-xs btn-success', target: :blank do
        content_tag(:i, '', class: 'fa fa-download') + ' Descargar archivo'
      end
    else
      cross_mark
    end
  end
end
