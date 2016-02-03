class AddTypeOfDepositoInformationToDepositos < ActiveRecord::Migration
  def change
    add_column :depositos, :pago_de_comisiones_o_impuestos, :boolean, default: false
    add_column :depositos, :referencia, :string
    add_column :depositos, :gasto_id, :integer
    add_foreign_key :depositos, :gastos
  end
end
