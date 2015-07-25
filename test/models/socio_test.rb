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

  test 'monto_disponible is 0 if there is no tope' do
    socio = FactoryGirl.build :socio
    assert_equal 0, socio.monto_disponible
  end

  test "monto_disponible should have the same value as tope's monto if there is monto_reservado" do
    socio = FactoryGirl.build :socio
    tope = FactoryGirl.build :tope, socio: socio, monto: 5
    assert_equal 5, socio.monto_disponible
  end

  test "monto_disponible tope's monto monto_reservado" do
    socio = FactoryGirl.build :socio
    tope = FactoryGirl.build :tope, socio: socio, monto: 5, monto_reservado: 2
    assert_equal 3, socio.monto_disponible
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
