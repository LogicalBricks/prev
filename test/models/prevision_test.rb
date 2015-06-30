require 'test_helper'

class PrevisionTest < ActiveSupport::TestCase
  should have_many(:depositos)
  should have_many(:apartados)
  should have_many(:topes)
  should have_many(:comisiones)
  should validate_presence_of(:fecha_inicial)
  should validate_presence_of(:fecha_final)
  should validate_presence_of(:monto)
  should validate_numericality_of(:monto).is_greater_than(0)
  should accept_nested_attributes_for(:apartados).allow_destroy(true)
  should accept_nested_attributes_for(:topes).allow_destroy(true)

  test "should validate date ranges" do
    prevision = FactoryGirl.build(
      :prevision,
      fecha_inicial: Date.today,
      fecha_final: Date.today - 1.days
    )
    prevision.save
    assert_includes prevision.errors[:base], "La fecha final debe ser mayor a la fecha inicial"
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
    FactoryGirl.create :deposito, prevision: prevision, monto: 15
    FactoryGirl.create :gasto, prevision: prevision, monto: 3
    FactoryGirl.create :gasto, prevision: prevision, monto: 2
    FactoryGirl.create :gasto, prevision: prevision, monto: 6
    FactoryGirl.create :comision, prevision: prevision, monto: 2
    FactoryGirl.create :comision, prevision: prevision, monto: 1
    assert_equal 14, prevision.reload.monto_gastado
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
