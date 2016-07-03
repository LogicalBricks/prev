class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_usuario!

private

  def usuario_actual
    current_usuario
  end
  helper_method :usuario_actual

  def prevision_activa
    @prevision_activa ||= prevision_de_sesion || prevision_por_omision
  end
  helper_method :prevision_activa

  def prevision_de_sesion
    session[:prevision_activa_id] && Prevision.find_by_id(session[:prevision_activa_id])
  end

  def prevision_por_omision
    Prevision.default
  end
end
