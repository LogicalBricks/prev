class AddRemanenteAndPresupuestoToPrevisiones < ActiveRecord::Migration
  def change
    add_column :previsiones, :monto_remanente, :decimal
    add_column :previsiones, :monto_presupuestado, :decimal
  end
end
