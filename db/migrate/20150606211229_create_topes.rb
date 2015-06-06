class CreateTopes < ActiveRecord::Migration
  def change
    create_table :topes do |t|
      t.string :socio
      t.decimal :monto
      t.references :prevision, index: true, foreign_key: true
      t.references :socio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
