class PrevisionActivasController < ApplicationController
  before_action :load_prevision

  # PUT prevision_activa/1
  def update
    PrevisionActiva.new(@prevision).activar
    redirect_to :back
  end

private

  def load_prevision
    @prevision = Prevision.find(params[:id])
  end
end
