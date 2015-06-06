class CreateSocios < ActiveRecord::Migration
  def change
    create_table :socios do |t|
      t.string :nombre
      t.references :usuario, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
