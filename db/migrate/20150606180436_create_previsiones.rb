class CreatePrevisiones < ActiveRecord::Migration
  def change
    create_table :previsiones do |t|
      t.date :fecha_inicial
      t.date :fecha_final
      t.decimal :monto

      t.timestamps null: false
    end
  end
end
