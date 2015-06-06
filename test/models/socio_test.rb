require 'test_helper'

class SocioTest < ActiveSupport::TestCase
  should belong_to(:usuario)
  should have_many(:gastos)
  should validate_presence_of(:nombre)
  should validate_presence_of(:usuario)
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
