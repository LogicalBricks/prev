class AddEsperaPagoImpuestosToGastos < ActiveRecord::Migration
  def change
    add_column :gastos, :espera_pago_impuestos, :boolean, default: true
    add_column :gastos, :deposito_id, :integer
    add_foreign_key :gastos, :depositos
  end
end
