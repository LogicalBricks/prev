require 'test_helper'

class ComisionTest < ActiveSupport::TestCase
  should belong_to :prevision
  should belong_to :deposito

  should validate_presence_of :prevision
  should validate_presence_of :fecha

  test '#to_be_paid? is true if no deposito has been associated' do
    comision = FactoryGirl.build :comision
    assert comision.to_be_paid?, "to_be_paid? is false when no deposito has been associated."
  end

  test '#to_be_paid? is false if a deposito has been associated' do
    prevision = FactoryGirl.create :prevision
    comision = FactoryGirl.build :comision, prevision: prevision, deposito: FactoryGirl.create(:deposito, prevision: prevision)
    refute comision.to_be_paid?, "to_be_paid? is true when a deposito has been associated."
  end
end

# == Schema Information
#
# Table name: comisiones
#
#  id           :integer          not null, primary key
#  monto        :decimal(, )
#  descripcion  :string
#  fecha        :date
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
