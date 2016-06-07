class PrevisionActivasController < ApplicationController
  before_action :load_prevision, only: [:update]

  # GET prevision_activa
  def show
  end

  # PUT prevision_activa/1
  def update
    session[:prevision_actual_id] = @prevision.id
    redirect_to :back
  end

private

  def load_prevision
    @prevision = Prevision.find(params[:id])
  end
end
