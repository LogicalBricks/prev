require 'test_helper'

class PrevisionTest < ActiveSupport::TestCase
  should have_many(:depositos)
  should have_many(:apartados)
  should have_many(:topes)
  should have_many(:comisiones)
  should validate_presence_of(:monto_presupuestado)
  should validate_numericality_of(:monto_presupuestado).is_greater_than(0)
  should accept_nested_attributes_for(:apartados).allow_destroy(true)
  should accept_nested_attributes_for(:topes).allow_destroy(true)

  test '#to_s is the periodo' do
    prevision = FactoryGirl.build(:prevision, periodo: 2014)
    assert_equal "2014", prevision.to_s
  end

  test "should generate date ranges" do
    prevision = FactoryGirl.build(:prevision, periodo: 2014)
    prevision.valid?
    assert_equal "2014/01/01".to_date, prevision.fecha_inicial
    assert_equal "2014/12/31".to_date, prevision.fecha_final
  end

  test '#monto_depositado is the sum of depositos for gastos' do
    prevision = FactoryGirl.create :prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 3
    FactoryGirl.create :deposito, prevision: prevision, monto: 2
    FactoryGirl.create :deposito, prevision: prevision, monto: 6
    FactoryGirl.create :deposito, prevision: prevision, monto: 4, pago_de_comisiones_o_impuestos: true
    assert_equal 11, prevision.reload.monto_depositado
  end

  test '#monto_gastado is the sum of gastos with no comisiones' do
    prevision = FactoryGirl.create :prevision
    apartado = FactoryGirl.create :apartado, prevision: prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 15
    tope = FactoryGirl.create :tope, monto: 15, prevision: prevision
    tope2 = FactoryGirl.create :tope, monto: 10, prevision: prevision
    FactoryGirl.create :gasto, apartado: apartado, monto: 3, socio: tope.socio
    FactoryGirl.create :gasto, apartado: apartado, monto: 2, socio: tope.socio
    FactoryGirl.create :gasto, apartado: apartado, monto: 6, socio: tope2.socio
    FactoryGirl.create :comision, prevision: prevision, monto: 2
    FactoryGirl.create :comision, prevision: prevision, monto: 1
    assert_equal 11, prevision.reload.monto_gastado
  end

  test 'la fecha es válida si está dentro del rango del periodo' do
    prevision = FactoryGirl.build :prevision, periodo: 2015
    prevision.valid?
    assert prevision.fecha_valida?("2015/02/11".to_date)
  end

  test 'la fecha no es válida si no está dentro del rango del periodo ' do
    prevision = FactoryGirl.build :prevision, periodo: 2015
    prevision.valid?
    refute prevision.fecha_valida?("2016/02/11".to_date)
    refute prevision.fecha_valida?("2014/02/11".to_date)
  end

  test '.de_periodo should return the prevision of this periodo ' do
    FactoryGirl.create :prevision, periodo: 2014, activa: true
    FactoryGirl.create :prevision, periodo: 2015, activa: false
    assert_equal 2014, Prevision.de_periodo(2014).periodo
    assert_equal 2015, Prevision.de_periodo(2015).periodo
  end
end

# == Schema Information
#
# Table name: previsiones
#
#  id                  :integer          not null, primary key
#  fecha_inicial       :date
#  fecha_final         :date
#  monto               :decimal(, )
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  monto_remanente     :decimal(, )
#  monto_presupuestado :decimal(, )
#
