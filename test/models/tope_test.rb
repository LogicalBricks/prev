require 'test_helper'

class TopeTest < ActiveSupport::TestCase
  should belong_to :prevision
  should belong_to :socio

  should validate_presence_of :monto
  should validate_presence_of :prevision
  should validate_presence_of :socio
  should validate_numericality_of(:monto).is_greater_than(0)
  should validate_numericality_of(:monto_reservado).is_greater_than_or_equal_to(0)
  should allow_value(nil, "").for(:monto_reservado)
end

# == Schema Information
#
# Table name: topes
#
#  id           :integer          not null, primary key
#  socio        :string
#  monto        :decimal(, )
#  prevision_id :integer
#  socio_id     :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
