require 'test_helper'

class ComisionesControllerTest < ActionController::TestCase
  setup do
    @comision = FactoryGirl.create :comision
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:comisiones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create comision" do
    assert_difference('Comision.count') do
      post :create, params: {
        comision: { descripcion: "Una descripción", fecha: Date.today, monto: 5, prevision_id: @comision.prevision }
      }
    end

    assert_redirected_to comision_path(assigns(:comision))
  end

  test "should show comision" do
    get :show, params: { id: @comision }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @comision }
    assert_response :success
  end

  test "should update comision" do
    patch :update, params: {
      id: @comision, comision: { descripcion: "Otra descripción", fecha: Date.today.yesterday, monto: 5.35, prevision_id: @comision.prevision_id }
    }
    assert_redirected_to comision_path(assigns(:comision))
  end

  test "should destroy comision" do
    assert_difference('Comision.count', -1) do
      delete :destroy, params: { id: @comision }
    end

    assert_redirected_to comisiones_path
  end
end
