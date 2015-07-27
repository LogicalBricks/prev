require 'test_helper'
require 'minitest/mock'

class GastoTest < ActiveSupport::TestCase
  should belong_to :socio
  should belong_to :proveedor
  should belong_to :apartado

  should validate_presence_of :socio
  should validate_presence_of :apartado
  should validate_presence_of :fecha
  should validate_presence_of :monto
  should validate_numericality_of(:monto).is_greater_than(0)

  should define_enum_for(:metodo_pago).with([:transferencia, :tarjeta, :reembolso])

  test "does not allow to set a fecha before the prevision's innitial date" do
    prevision = FactoryGirl.create :prevision, periodo: 2016
    gasto = FactoryGirl.build :gasto, fecha: Date.today, apartado: FactoryGirl.create(:apartado, prevision: prevision)
    refute gasto.valid?
    assert gasto.errors[:fecha].include?("debe estar en el rango de fechas de la previsión")
  end

  test "does not allow to set a fecha after the prevision's final date" do
    prevision = FactoryGirl.create :prevision, periodo: 2014
    gasto = FactoryGirl.build :gasto, fecha: Date.today, apartado: FactoryGirl.create(:apartado, prevision: prevision)
    refute gasto.valid?
    assert gasto.errors[:fecha].include?("debe estar en el rango de fechas de la previsión")
  end

  test "should not allow save a monto greater than the apartado's monto" do
    apartado = FactoryGirl.build :apartado, monto_maximo: 100
    gasto = FactoryGirl.build :gasto, apartado: apartado, monto: 101
    refute gasto.valid?
    assert gasto.errors[:monto].include?("no puede ser mayor al monto del apartado")
  end

  test "should allow save a monto fewer than the apartado's monto" do
    apartado = FactoryGirl.build :apartado, monto_maximo: 100
    gasto = FactoryGirl.build :gasto, apartado: apartado, monto: 99
    refute gasto.errors[:monto].include?("no puede ser mayor al monto del apartado")
  end

  test "should not allow save a monto that makes total greater than the apartado's monto" do
    socio = FactoryGirl.create :socio
    FactoryGirl.create :tope, socio: socio, monto: 10
    apartado = FactoryGirl.create :apartado, monto_maximo: 10
    FactoryGirl.create :deposito, monto: 10, prevision: apartado.prevision
    FactoryGirl.create :gasto, apartado: apartado, monto: 9, socio: socio
    gasto = FactoryGirl.build :gasto, apartado: apartado, monto: 2, socio: socio
    refute gasto.valid?
    assert gasto.errors[:monto].include?("no puede ser mayor al monto del apartado")
  end

  test "should not save a monto greater than socio's monto_disponible" do
    socio = FactoryGirl.build_stubbed :socio
    gasto = FactoryGirl.build :gasto, socio: socio, monto: 11
    socio.stub :monto_disponible, 10 do
      refute gasto.valid?
      assert gasto.errors[:monto].include?("no puede ser mayor al monto tope del socio")
    end
  end

  test "#supera_monto_socio? should be true if monto is greater than socio's monto_disponible" do
    socio = FactoryGirl.build_stubbed :socio
    gasto = FactoryGirl.build :gasto, socio: socio, monto: 11
    socio.stub :monto_disponible, 10 do
      assert gasto.supera_monto_socio?
    end
  end

  test "should not save a monto that makes it exceed socio's monto_disponible" do
    tope = FactoryGirl.create :tope, monto: 10
    FactoryGirl.create :deposito, monto: 15, prevision: tope.prevision
    apartado = FactoryGirl.create :apartado, monto_maximo: 15, prevision: tope.prevision
    FactoryGirl.create :gasto, socio: tope.socio, monto: 9, apartado: apartado
    gasto = FactoryGirl.build :gasto, socio: tope.socio, monto: 2, apartado: apartado
    refute gasto.valid?
    assert gasto.errors[:monto].include?("no puede ser mayor al monto tope del socio")
    assert gasto.supera_monto_socio?
  end

  test "should have an error on monto when it exceeds the prevision's monto depositado" do
    tope = FactoryGirl.create :tope
    FactoryGirl.create :deposito, prevision: tope.prevision, monto: 8
    FactoryGirl.create :gasto, socio: tope.socio, monto: 3, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto = FactoryGirl.build :gasto, socio: tope.socio, monto: 6, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto.valid?
    assert gasto.errors[:monto].include?("no puede ser mayor al monto depositado a la previsión")
  end

  test "should not have an error on monto when it does not exceed the prevision's monto depositado" do
    tope = FactoryGirl.create :tope
    FactoryGirl.create :deposito, prevision: tope.prevision, monto: 9
    FactoryGirl.create :gasto, socio: tope.socio, monto: 3, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto = FactoryGirl.build :gasto, socio: tope.socio, monto: 5, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto.valid?
    refute gasto.errors[:monto].include?("no puede ser mayor al monto depositado a la previsión")
  end

  test "should not have an error on monto when it is modified but not exceed the prevision's monto depositado" do
    tope = FactoryGirl.create :tope
    FactoryGirl.create :deposito, prevision: tope.prevision, monto: 9
    gasto = FactoryGirl.create :gasto, socio: tope.socio, monto: 8, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto.update monto: 3
    refute gasto.errors[:monto].include?("no puede ser mayor al monto depositado a la previsión")
  end

  test "should not have an error on monto when it is modified but not exceed socio's apartado's monto" do
    tope = FactoryGirl.create :tope, monto: 10
    FactoryGirl.create :deposito, monto: 15, prevision: tope.prevision
    apartado = FactoryGirl.create :apartado, monto_maximo: 15, prevision: tope.prevision
    gasto = FactoryGirl.create :gasto, socio: tope.socio, monto: 9, apartado: apartado
    gasto.update monto: 7
    refute gasto.errors[:monto].include?("no puede ser mayor al monto del apartado")
  end

  test "should not have an error on monto when it is modified but not exceed socio's monto_disponible" do
    tope = FactoryGirl.create :tope, monto: 10
    FactoryGirl.create :deposito, monto: 15, prevision: tope.prevision
    apartado = FactoryGirl.create :apartado, monto_maximo: 15, prevision: tope.prevision
    gasto = FactoryGirl.create :gasto, socio: tope.socio, monto: 9, apartado: apartado
    gasto.update monto: 2
    refute gasto.errors[:monto].include?("no puede ser mayor al monto tope del socio")
    refute gasto.supera_monto_socio?
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
