# == Schema Information
#
# Table name: rubros
#
#  id           :integer          not null, primary key
#  nombre       :string
#  descripcion  :text
#  agrupador_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class RubroTest < ActiveSupport::TestCase
  should validate_presence_of(:nombre)
  should validate_presence_of(:descripcion)
end
