class CreateDepositos < ActiveRecord::Migration
  def change
    create_table :depositos do |t|
      t.decimal :monto
      t.date :fecha
      t.text :descripcion
      t.references :prevision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
