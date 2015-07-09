require 'test_helper'

class ComisionTest < ActiveSupport::TestCase
  should belong_to :prevision

  should validate_presence_of :prevision
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
