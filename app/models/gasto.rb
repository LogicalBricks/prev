class Gasto < ActiveRecord::Base
  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, :apartado, presence: true
  validates :monto, numericality: { greater_than: 0 }
  validate :fecha_dentro_de_vigencia_de_prevision

private

  def fecha_dentro_de_vigencia_de_prevision
    errors.add :fecha, 'debe ser posterior al inicio de la prevision' if apartado and fecha < apartado.fecha_inicial
    errors.add :fecha, 'debe ser anterior al final de la prevision' if apartado and fecha > apartado.fecha_final
  end
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
