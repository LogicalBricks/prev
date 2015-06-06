require 'test_helper'

class DepositoTest < ActiveSupport::TestCase
  should belong_to :prevision
  should validate_presence_of :fecha
  should validate_presence_of :prevision
  should validate_numericality_of(:monto).is_greater_than(0)

  test "does not allow to set a fecha before the prevision's innitial date" do
    prevision = FactoryGirl.build_stubbed :prevision, fecha_inicial: Date.today, fecha_final: Date.today.tomorrow
    deposito = FactoryGirl.build :deposito, fecha: 1.month.ago, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:fecha].size
  end

  test "does not allow to set a fecha after the prevision's final date" do
    prevision = FactoryGirl.build_stubbed :prevision, fecha_inicial: Date.today, fecha_final: Date.today.tomorrow
    deposito = FactoryGirl.build :deposito, fecha: 1.month.from_now, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:fecha].size
  end

  test "does not allow to set a monto greater than the prevision's monto" do
    prevision = FactoryGirl.build_stubbed :prevision, monto: 100
    deposito = FactoryGirl.build :deposito, monto: 101, prevision: prevision
    refute deposito.valid?
    assert_equal 1, deposito.errors[:monto].size
  end
end

# == Schema Information
#
# Table name: depositos
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  fecha        :date
#  descripcion  :text
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
