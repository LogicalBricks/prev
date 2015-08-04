class MontoCercaDeLimiteMailer < ApplicationMailer
  add_template_helper(HomeHelper)

  def notificacion(socio, apartado)
    @socio = socio
    @apartado = apartado
    mail(to: @socio.usuario.email, subject: 'Tu monto de previsión social está llegando al límite')
  end
end
