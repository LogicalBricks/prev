class Gasto < ActiveRecord::Base
  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, presence: true
  validates :monto, numericality: { greater_than: 0 }
end

# == Schema Information
#
# Table name: gastos
#
#  id           :integer          not null, primary key
#  factura_xml  :string
#  factura_pdf  :string
#  solicitud    :string
#  monto        :decimal(, )
#  fecha        :date
#  metodo_pago  :integer          default(0)
#  descripcion  :text
#  socio_id     :integer
#  proveedor_id :integer
#  apartado_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_gastos_on_apartado_id   (apartado_id)
#  index_gastos_on_proveedor_id  (proveedor_id)
#  index_gastos_on_socio_id      (socio_id)
#
# Foreign Keys
#
#  fk_rails_5c1017f265  (socio_id => socios.id)
#  fk_rails_982ad725a5  (apartado_id => apartados.id)
#  fk_rails_e4c5f4d318  (proveedor_id => proveedores.id)
#
