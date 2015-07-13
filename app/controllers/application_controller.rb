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

  def prevision_actual
    @prevision_actual ||= Prevision.de_periodo(Date.today.year)
  end
  helper_method :prevision_actual
end
