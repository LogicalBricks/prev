require 'test_helper'

class RubroTest < ActiveSupport::TestCase
  should validate_presence_of(:nombre)
  should validate_presence_of(:descripcion)
end
