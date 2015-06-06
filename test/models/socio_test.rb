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
# Indexes
#
#  index_socios_on_usuario_id  (usuario_id)
#
# Foreign Keys
#
#  fk_rails_0b8e8596bb  (usuario_id => usuarios.id)
#
