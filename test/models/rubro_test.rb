require 'test_helper'

class RubroTest < ActiveSupport::TestCase
  should belong_to(:agrupador)
  should validate_presence_of(:nombre)
end

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
