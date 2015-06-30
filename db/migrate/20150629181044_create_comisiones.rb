class CreateComisiones < ActiveRecord::Migration
  def change
    create_table :comisiones do |t|
      t.decimal :monto
      t.string :descripcion
      t.date :fecha
      t.references :prevision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
