require 'test_helper'

class SocioTest < ActiveSupport::TestCase
  should belong_to(:usuario)
  should accept_nested_attributes_for(:usuario)
  should have_many(:gastos)
  should have_one(:tope)
  should validate_presence_of(:nombre)
  should validate_presence_of(:usuario)

  test 'monto_tope is 0 if there is no tope' do
    socio = FactoryGirl.build :socio
    assert_equal 0, socio.monto_tope
  end

  test "monto_tope should have the same value as tope's monto" do
    socio = FactoryGirl.build :socio
    tope = FactoryGirl.build :tope, socio: socio, monto: 5
    assert_equal 5, socio.monto_tope
  end

  test 'monto_reservado is 0 if there is no tope' do
    socio = FactoryGirl.build :socio
    assert_equal 0, socio.monto_reservado
  end

  test "monto_reservado should have the same value as tope's reservado" do
    socio = FactoryGirl.build :socio
    tope = FactoryGirl.build :tope, socio: socio, monto: 5, monto_reservado: 3
    assert_equal 3, socio.monto_reservado
  end

  test 'monto_disponible is 0 if there is no tope' do
    socio = FactoryGirl.build :socio
    assert_equal 0, socio.monto_disponible
  end

  test "monto_disponible is monto_tope - monto_reservado - monto_gastado" do
    prevision = FactoryGirl.create :prevision, monto: 20
    tope = FactoryGirl.build :tope, monto: 15, monto_reservado: 4, prevision: prevision
    FactoryGirl.create :deposito, monto: 20, prevision: prevision
    FactoryGirl.create :gasto, monto: 3, socio: tope.socio, apartado: FactoryGirl.create(:apartado, prevision: prevision, monto_maximo: 15)
    assert_equal 8, tope.socio.monto_disponible
  end
end

# == Schema Information
#
# Table name: socios
#
#  id         :integer          not null, primary key
#  nombre     :string
#  usuario_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
