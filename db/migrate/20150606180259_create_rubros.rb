class CreateRubros < ActiveRecord::Migration
  def change
    create_table :rubros do |t|
      t.string :nombre
      t.text :descripcion

      t.timestamps null: false
    end
  end
end
