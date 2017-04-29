require 'test_helper'

class ApartadosControllerTest < ActionController::TestCase
  setup do
    @apartado = FactoryGirl.create :apartado
  end

  test "should show apartado" do
    get :show, params: { id: @apartado }
    assert_response :success
  end
end
