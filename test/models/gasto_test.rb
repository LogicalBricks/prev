require 'test_helper'

class GastoTest < ActiveSupport::TestCase
  should belong_to :socio
  should belong_to :proveedor
  should belong_to :apartado

  should validate_presence_of :socio
  should validate_presence_of :apartado
  should validate_numericality_of(:monto).is_greater_than(0)

  def stub_fecha_inicial_and_fecha_final(apartado, fecha_inicial, fecha_final)
    def apartado.fecha_inicial; Date.today; end
    def apartado.fecha_final; Date.today.tomorrow; end
  end

  test "does not allow to set a fecha before the prevision's innitial date" do
    apartado = FactoryGirl.build_stubbed :apartado
    stub_fecha_inicial_and_fecha_final(apartado, Date.today, Date.today.tomorrow)
    gasto = FactoryGirl.build :gasto, fecha: 1.month.ago, apartado: apartado
    gasto.valid?
    assert_equal 1, gasto.errors[:fecha].size
  end

  test "does not allow to set a fecha after the prevision's final date" do
    apartado = FactoryGirl.build_stubbed :apartado
    stub_fecha_inicial_and_fecha_final(apartado, Date.today, Date.today.tomorrow)
    gasto = FactoryGirl.build :gasto, fecha: 1.month.from_now, apartado: apartado
    gasto.valid?
    assert_equal 1, gasto.errors[:fecha].size
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
