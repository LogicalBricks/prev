require 'test_helper'

class ProveedorTest < ActiveSupport::TestCase
  should have_many(:gastos)
  should validate_presence_of(:nombre)
end
