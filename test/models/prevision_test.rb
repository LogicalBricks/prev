require 'test_helper'

class PrevisionTest < ActiveSupport::TestCase
  should have_many(:depositos)
  should have_many(:apartados)
  should have_many(:topes)
  should have_many(:comisiones)
  should validate_presence_of(:monto)
  should validate_numericality_of(:monto).is_greater_than(0)
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

  test '#monto_depositado is the sum of depositos' do
    prevision = FactoryGirl.create :prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 3
    FactoryGirl.create :deposito, prevision: prevision, monto: 2
    FactoryGirl.create :deposito, prevision: prevision, monto: 6
    assert_equal 11, prevision.reload.monto_depositado
  end

  test '#monto_gastado is the sum of gastos and comisiones' do
    prevision = FactoryGirl.create :prevision
    apartado = FactoryGirl.create :apartado, prevision: prevision
    FactoryGirl.create :deposito, prevision: prevision, monto: 15
    FactoryGirl.create :gasto, apartado: apartado, monto: 3
    FactoryGirl.create :gasto, apartado: apartado, monto: 2
    FactoryGirl.create :gasto, apartado: apartado, monto: 6
    FactoryGirl.create :comision, prevision: prevision, monto: 2
    FactoryGirl.create :comision, prevision: prevision, monto: 1
    assert_equal 14, prevision.reload.monto_gastado
  end

  test 'la fecha es válida si está dentro del rango del periodo' do
    prevision = Prevision.new periodo: 2015
    prevision.valid?
    assert prevision.fecha_valida?("2015/02/11".to_date)
  end

  test 'la fecha no es válida si no está dentro del rango del periodo ' do
    prevision = Prevision.new periodo: 2015
    prevision.valid?
    refute prevision.fecha_valida?("2016/02/11".to_date)
    refute prevision.fecha_valida?("2014/02/11".to_date)
  end
end

# == Schema Information
#
# Table name: previsiones
#
#  id            :integer          not null, primary key
#  fecha_inicial :date
#  fecha_final   :date
#  monto         :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
