class AddDepositoIdToComisiones < ActiveRecord::Migration
  def change
    add_column :comisiones, :deposito_id, :integer
  end
end
