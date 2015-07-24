require 'test_helper'

class SocioTest < ActiveSupport::TestCase
  should belong_to(:usuario)
  should accept_nested_attributes_for(:usuario)
  should have_many(:gastos)
  should have_one(:tope)
  should validate_presence_of(:nombre)
  should validate_presence_of(:usuario)

  test "monto should have the same value as tope's monto" do
    socio = FactoryGirl.build :socio
    tope = FactoryGirl.build :tope, socio: socio
    assert_equal tope.monto, socio.monto_disponible
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
