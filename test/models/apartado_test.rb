require 'test_helper'

class ApartadoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: apartados
#
#  id           :integer          not null, primary key
#  monto_maximo :decimal(, )
#  rubro_id     :integer
#  prevision_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_apartados_on_prevision_id  (prevision_id)
#  index_apartados_on_rubro_id      (rubro_id)
#
# Foreign Keys
#
#  fk_rails_a7b482130a  (rubro_id => rubros.id)
#  fk_rails_b96ecf8df7  (prevision_id => previsiones.id)
#
