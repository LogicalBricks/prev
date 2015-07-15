require 'test_helper'

class ApartadoTest < ActiveSupport::TestCase
  should belong_to(:rubro)
  should belong_to(:prevision)
  should have_many(:gastos)
  should validate_presence_of(:rubro)
  should validate_presence_of(:prevision)
  should validate_presence_of(:monto_maximo)
  should validate_numericality_of(:monto_maximo).is_greater_than(0)

  test "should validate monto not to rebase prevision's monto" do
    prevision = FactoryGirl.build :prevision, monto: 100
    apartado = prevision.apartados.build monto_maximo: 99
    apartado.valid?
    refute apartado.errors[:monto_maximo].include?("rebasa el monto total de la previsión")

    apartado.monto_maximo = 101
    apartado.valid?
    assert apartado.errors[:monto_maximo].include?("rebasa el monto total de la previsión")
  end

  test 'should return the fecha_inicial from prevision' do
    prevision = FactoryGirl.build :prevision, fecha_inicial: Date.today
    apartado = FactoryGirl.build :apartado, prevision: prevision
    assert_equal Date.today, apartado.fecha_inicial

    prevision.fecha_inicial = 1.month.ago
    assert_equal 1.month.ago.to_date, apartado.fecha_inicial
  end

  test 'should return the fecha_final from prevision' do
    prevision = FactoryGirl.build :prevision, fecha_final: Date.today
    apartado = FactoryGirl.build :apartado, prevision: prevision
    assert_equal Date.today, apartado.fecha_final

    prevision.fecha_final = 1.month.ago
    assert_equal 1.month.ago.to_date, apartado.fecha_final
  end
end

# == Schema Information
#
# Table name: apartados
#
#  id           :integer          not null, primary key
#  monto_maximo :decimal(, )
#  rubro_id     :integer
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
