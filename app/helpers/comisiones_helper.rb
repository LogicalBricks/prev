module ComisionesHelper
  def mostrar_comentario(comentario)
    content_tag :i, nil, class: "fa fa-comment-o", title: comentario if comentario.present?
  end
end
