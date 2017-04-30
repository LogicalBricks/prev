class PrevisionActivasController < ApplicationController
  before_action :load_prevision, only: [:update]

  # GET prevision_activa
  def show
    session[:return_to] ||= request.referer
  end

  # PUT prevision_activa/1
  def update
    session[:prevision_activa_id] = @prevision.id
    if session[:return_to].present?
      redirect_to(session[:return_to])
      session[:return_to] = nil
    else
      render :show
    end
  end

private

  def load_prevision
    @prevision = Prevision.find(params[:id])
  end
end
