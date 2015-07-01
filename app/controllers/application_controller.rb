class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_usuario!

  helper_method :usuario_actual

private

  def usuario_actual
    current_usuario
  end
end
