require 'test_helper'

class ProveedorTest < ActiveSupport::TestCase
  should have_many(:gastos)
  should validate_presence_of(:nombre)
end

# == Schema Information
#
# Table name: proveedores
#
#  id         :integer          not null, primary key
#  nombre     :string
#  rfc        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
