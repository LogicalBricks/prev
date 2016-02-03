require 'test_helper'

class GastoTest < ActiveSupport::TestCase
  should belong_to :socio
  should belong_to :proveedor
  should belong_to :apartado
  should have_one :deposito

  should validate_presence_of :socio
  should validate_presence_of :apartado
  should validate_presence_of :fecha
  should validate_presence_of :monto
  should validate_numericality_of(:monto).is_greater_than(0)

  should define_enum_for(:metodo_pago).with([:transferencia, :tarjeta, :reembolso])

  test "does not allow to set a fecha before the prevision's innitial date" do
    prevision = FactoryGirl.create :prevision, periodo: 2016
    gasto = FactoryGirl.build :gasto, fecha: "2015-02-04".to_date, apartado: FactoryGirl.create(:apartado, prevision: prevision)
    refute gasto.valid?
    assert gasto.errors[:fecha].include?("debe estar en el rango de fechas de la previsión")
  end

  test "does not allow to set a fecha after the prevision's final date" do
    prevision = FactoryGirl.create :prevision, periodo: 2014
    gasto = FactoryGirl.build :gasto, fecha: "2015-02-04".to_date, apartado: FactoryGirl.create(:apartado, prevision: prevision)
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
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 10, monto_depositado: 10
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
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
      assert gasto.errors[:monto].include?("no puede ser mayor al monto disponible del socio")
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
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
    FactoryGirl.create :gasto, apartado: apartado, monto: 9, socio: socio

    gasto = FactoryGirl.build :gasto, socio: socio, monto: 2, apartado: apartado
    refute gasto.valid?
    assert gasto.errors[:monto].include?("no puede ser mayor al monto disponible del socio")
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
    assert gasto.valid?
  end

  test "should not have an error on monto when it is modified but not exceed the prevision's monto depositado" do
    tope = FactoryGirl.create :tope
    FactoryGirl.create :deposito, prevision: tope.prevision, monto: 9
    gasto = FactoryGirl.create :gasto, socio: tope.socio, monto: 8, apartado: FactoryGirl.create(:apartado, prevision: tope.prevision)
    gasto.update monto: 3
    assert gasto.errors[:monto].empty?
  end

  test "should not have an error on monto when it is modified but not exceed socio's apartado's monto" do
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
    gasto = FactoryGirl.create :gasto, socio: socio, monto: 9, apartado: apartado

    gasto.update monto: 7
    assert gasto.errors[:monto].empty?
  end

  test "should not have an error on monto when it is modified but not exceed socio's monto_disponible" do
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
    gasto = FactoryGirl.create :gasto, socio: socio, monto: 9, apartado: apartado

    gasto.update monto: 2
    refute gasto.errors[:monto].include?("no puede ser mayor al monto disponible del socio")
    refute gasto.supera_monto_socio?
  end

  test 'should have an error on descontar_de_reservado if descontar_de_reservado flag is true and validador_monto_reservado is not valid' do
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
    gasto = FactoryGirl.build :gasto, socio: socio, monto: 4, apartado: apartado, descontar_de_reservado: true, validador_monto_reservado: validador_monto_reservado_invalido
    refute gasto.valid?
    assert_equal 1, gasto.errors[:descontar_de_reservado].size
  end

  test 'should not have an error on descontar_de_reservado if descontar_de_reservado flag is true and validador_monto_reservado is valid' do
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first
    gasto = FactoryGirl.build :gasto, socio: socio, monto: 4, apartado: apartado, descontar_de_reservado: true, validador_monto_reservado: validador_monto_reservado_valido
    assert gasto.valid?
  end

  test 'should call call in monto_reservado_updater when descontar_de_reservado is true and validator_monto_reservado is valid' do
    prevision = FactoryGirl.create :prevision, :con_apartado, :con_deposito, apartado_monto_maximo: 15, monto_depositado: 15
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 10, prevision: prevision
    apartado = prevision.apartados.first

    monto_reservado_updater = Minitest::Mock.new
    monto_reservado_updater.expect :call, true
    FactoryGirl.create(:gasto, socio: socio, monto: 4, apartado: apartado,
                       descontar_de_reservado: true,
                       validador_monto_reservado: validador_monto_reservado_valido,
                       monto_reservado_updater: monto_reservado_updater)
    monto_reservado_updater.verify
  end

  def validador_monto_reservado_valido
    Class.new do
      def valid?
        true
      end
    end.new
  end

  def validador_monto_reservado_invalido
    Class.new do
      def valid?
        false
      end
    end.new
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
