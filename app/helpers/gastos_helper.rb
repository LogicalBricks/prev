module GastosHelper
  def link_to_file objeto, metodo, format: :default
    if objeto.send "#{ metodo }?"
      if format == :default
        default_link_to_file(objeto, metodo)
      elsif format == :short
        short_link_to_file(objeto, metodo)
      end
    else
      cross_mark
    end
  end

  def default_link_to_file(objeto, metodo)
    link_to objeto.send(metodo).url, class: 'btn btn-xs btn-success', target: :blank do
      content_tag(:i, '', class: 'fa fa-download') + ' Descargar archivo'
    end
  end

  def short_link_to_file(objeto, metodo)
    link_to objeto.send(metodo).url, target: :blank do
      check_mark
    end
  end
end
