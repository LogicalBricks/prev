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

class Gasto < ActiveRecord::Base
  # == Associations ==
  belongs_to :socio
  belongs_to :proveedor
  belongs_to :apartado

  # == Validations ==
  validates :socio, presence: true
  validates :monto, numericality: { greater_than: 0 }
end
