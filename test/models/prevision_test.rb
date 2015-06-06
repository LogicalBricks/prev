require 'test_helper'

class PrevisionTest < ActiveSupport::TestCase
  should have_many(:depositos)
  should have_many(:apartados)
  should have_many(:topes)
  should validate_presence_of(:fecha_inicial)
  should validate_presence_of(:fecha_final)
  should validate_presence_of(:monto)
  should validate_numericality_of(:monto).is_greater_than(0)
  should accept_nested_attributes_for(:apartados)
  should accept_nested_attributes_for(:topes)

  test "should validate date ranges" do
    prevision = FactoryGirl.build(
      :prevision,
      fecha_inicial: Date.today,
      fecha_final: Date.today - 1.days
    )
    prevision.save
    assert_includes prevision.errors[:base], "La fecha final debe ser mayor a la fecha inicial"
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
