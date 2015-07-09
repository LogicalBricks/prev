class HomeController < ApplicationController
  def index
    render :no_socio and return if Socio.count == 0
    render :no_rubro and return if Rubro.count == 0
    render :no_prevision and return if Prevision.count == 0
    render :no_deposito and return if Deposito.count == 0

    @prevision = Prevision.first
    @movimientos = (depositos + gastos + comisiones).sort_by(&:fecha)
  end

private

  def depositos
    @prevision.depositos
  end

  def gastos
    @prevision.gastos
  end

  def comisiones
    @prevision.comisiones
  end
end
