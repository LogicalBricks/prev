require 'test_helper'

class ComisionTest < ActiveSupport::TestCase
  should belong_to :prevision
  should belong_to :deposito

  should validate_presence_of :prevision
  should validate_presence_of :fecha
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
