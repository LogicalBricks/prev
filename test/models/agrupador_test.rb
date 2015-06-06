require 'test_helper'

class AgrupadorTest < ActiveSupport::TestCase
  should validate_presence_of :nombre
  should have_many :rubros
end

# == Schema Information
#
# Table name: agrupadores
#
#  id         :integer          not null, primary key
#  nombre     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
