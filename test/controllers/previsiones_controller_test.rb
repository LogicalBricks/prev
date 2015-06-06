require 'test_helper'

class PrevisionesControllerTest < ActionController::TestCase
  setup do
    @prevision = previsiones(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:previsiones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prevision" do
    assert_difference('Prevision.count') do
      post :create, prevision: { fecha_final: @prevision.fecha_final, fecha_inicial: @prevision.fecha_inicial, monto: @prevision.monto }
    end

    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should show prevision" do
    get :show, id: @prevision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prevision
    assert_response :success
  end

  test "should update prevision" do
    patch :update, id: @prevision, prevision: { fecha_final: @prevision.fecha_final, fecha_inicial: @prevision.fecha_inicial, monto: @prevision.monto }
    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should destroy prevision" do
    assert_difference('Prevision.count', -1) do
      delete :destroy, id: @prevision
    end

    assert_redirected_to previsiones_path
  end
end
