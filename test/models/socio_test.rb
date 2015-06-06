require 'test_helper'

class SocioTest < ActiveSupport::TestCase
  should belong_to(:usuario)
  should have_many(:gastos)
  should validate_presence_of(:nombre)
  should validate_presence_of(:usuario)
end
