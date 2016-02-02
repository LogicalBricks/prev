require 'test_helper'

class PrevisionActivaTest < ActiveSupport::TestCase
  def test_activar_is_true_if_prevision_was_updated
    prevision = FactoryGirl.create :prevision, activa: false
    assert PrevisionActiva.new(prevision).activar, "#activar is not true."
  end

  def test_activar_changes_the_prevision_attribute_activa_to_true
    prevision = FactoryGirl.create :prevision, activa: false
    PrevisionActiva.new(prevision).activar
    assert prevision.activa?, "Prevision is not active after call activar."
  end

  def test_activar_changes_the_previous_prevision_attribute_activa_to_false
    prevision_anterior = FactoryGirl.create :prevision, activa: true
    prevision = FactoryGirl.create :prevision, activa: false
    PrevisionActiva.new(prevision).activar
    refute prevision_anterior.reload.activa?, "Previous active prevision is still active."
  end
end
