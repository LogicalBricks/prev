class AddSubtotalAndIvaToGastos < ActiveRecord::Migration
  def change
    add_column :gastos, :iva, :decimal
    add_column :gastos, :total, :decimal
  end
end
