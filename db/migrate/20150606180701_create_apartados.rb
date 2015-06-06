class CreateApartados < ActiveRecord::Migration
  def change
    create_table :apartados do |t|
      t.decimal :monto_maximo
      t.references :rubro, index: true, foreign_key: true
      t.references :prevision, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
