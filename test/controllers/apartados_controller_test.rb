require 'test_helper'

class ApartadosControllerTest < ActionController::TestCase
  setup do
    @apartado = FactoryGirl.create :apartado
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:apartados)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create apartado" do
    assert_difference('Apartado.count') do
      post :create, apartado: { monto_maximo: @apartado.monto_maximo, prevision_id: @apartado.prevision_id, rubro_id: @apartado.rubro_id }
    end

    assert_redirected_to apartado_path(assigns(:apartado))
  end

  test "should show apartado" do
    get :show, id: @apartado
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @apartado
    assert_response :success
  end

  test "should update apartado" do
    patch :update, id: @apartado, apartado: { monto_maximo: @apartado.monto_maximo, prevision_id: @apartado.prevision_id, rubro_id: @apartado.rubro_id }
    assert_redirected_to apartado_path(assigns(:apartado))
  end

  test "should destroy apartado" do
    assert_difference('Apartado.count', -1) do
      delete :destroy, id: @apartado
    end

    assert_redirected_to apartados_path
  end
end
