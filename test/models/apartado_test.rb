require 'test_helper'

class ApartadoTest < ActiveSupport::TestCase
  should validate_presence_of(:rubro)
  should validate_presence_of(:prevision)
  should validate_presence_of(:monto_maximo)
  should validate_numericality_of(:monto_maximo).is_greater_than(0)

  test "should validate monto not to rebase prevision's monto" do
    prevision = FactoryGirl.build :prevision, monto: 100
    apartado = prevision.apartados.build monto_maximo: 101
    refute apartado.valid?
    assert_equal 1, apartado.errors[:monto].size
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
