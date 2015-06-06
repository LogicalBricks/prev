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

require 'test_helper'

class GastoTest < ActiveSupport::TestCase
  should belong_to :socio
  should belong_to :proveedor
  should belong_to :apartado

  should validate_presence_of :socio
  should validate_numericality_of(:monto).is_greater_than(0)
end
