require 'test_helper'
require 'minitest/mock'

class GastoTest < ActiveSupport::TestCase
  should belong_to :socio
  should belong_to :proveedor
  should belong_to :apartado

  should validate_presence_of :socio
  should validate_presence_of :apartado
  should validate_numericality_of(:monto).is_greater_than(0)

  test "does not allow to set a fecha before the prevision's innitial date" do
    apartado = FactoryGirl.build_stubbed :apartado
    gasto = FactoryGirl.build :gasto, fecha: 1.month.ago, apartado: apartado
    apartado.stub :fecha_inicial, Date.today do
      refute gasto.valid?
      assert_equal 1, gasto.errors[:fecha].size
    end
  end

  test "does not allow to set a fecha after the prevision's final date" do
    apartado = FactoryGirl.build_stubbed :apartado
    gasto = FactoryGirl.build :gasto, fecha: 1.month.from_now, apartado: apartado
    apartado.stub :fecha_final, Date.today.tomorrow do
      refute gasto.valid?
      assert_equal 1, gasto.errors[:fecha].size
    end
  end

  test "should not allow save a monto greater than the apartado's monto " do
    apartado = FactoryGirl.build :apartado, monto_maximo: 100
    gasto = FactoryGirl.build :gasto, apartado: apartado, monto: 101
    refute gasto.valid?
    assert_equal 1, gasto.errors[:monto].size
  end

  test "should allow save a monto fewer than the apartado's monto " do
    apartado = FactoryGirl.build :apartado, monto_maximo: 100
    gasto = FactoryGirl.build :gasto, apartado: apartado, monto: 99
    gasto.valid?
    assert_equal 0, gasto.errors[:monto].size
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
