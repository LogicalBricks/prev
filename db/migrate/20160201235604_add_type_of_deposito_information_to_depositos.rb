class AddTypeOfDepositoInformationToDepositos < ActiveRecord::Migration
  def change
    add_column :depositos, :pago_de_comisiones_o_impuestos, :boolean, default: false
    add_column :depositos, :referencia, :string
  end
end
