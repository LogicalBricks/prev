class AddMontoReservadoToTopes < ActiveRecord::Migration
  def change
    add_column :topes, :monto_reservado, :decimal
  end
end
