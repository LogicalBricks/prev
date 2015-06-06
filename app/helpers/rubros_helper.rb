module RubrosHelper
  def markdown(texto)
    options = { hard_wrap: true, filter_html: true }
    Redcarpet::Markdown.new(Redcarpet::Render::HTML, options).render(texto)
  end
end
