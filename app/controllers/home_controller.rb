class HomeController < ApplicationController
  def index
    render :no_rubro and return if Rubro.count == 0
    render :no_socio and return if Socio.count == 0
    render :no_prevision and return if Prevision.count == 0

    @prevision = Prevision.first
  end
end
