# Preview all emails at http://localhost:3000/rails/mailers/monto_cerca_de_limite_mailer
class MontoCercaDeLimiteMailerPreview < ActionMailer::Preview
  def notificacion
    MontoCercaDeLimiteMailer.notificacion(Socio.first, Apartado.first)
  end
end
