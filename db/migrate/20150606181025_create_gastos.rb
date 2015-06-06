class CreateGastos < ActiveRecord::Migration
  def change
    create_table :gastos do |t|
      t.string :factura_xml
      t.string :factura_pdf
      t.string :solicitud
      t.decimal :monto
      t.date :fecha
      t.integer :metodo_pago
      t.text :descripcion
      t.references :socio, index: true, foreign_key: true
      t.references :proveedor, index: true, foreign_key: true
      t.references :apartado, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
