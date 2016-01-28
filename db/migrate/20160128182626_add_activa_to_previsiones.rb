class AddActivaToPrevisiones < ActiveRecord::Migration
  def change
    add_column :previsiones, :activa, :boolean, default: false
  end
end
