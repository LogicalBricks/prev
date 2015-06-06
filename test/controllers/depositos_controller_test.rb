require 'test_helper'

class DepositosControllerTest < ActionController::TestCase
  setup do
    @deposito = depositos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito" do
    assert_difference('Deposito.count') do
      post :create, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should show deposito" do
    get :show, id: @deposito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposito
    assert_response :success
  end

  test "should update deposito" do
    patch :update, id: @deposito, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id }
    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should destroy deposito" do
    assert_difference('Deposito.count', -1) do
      delete :destroy, id: @deposito
    end

    assert_redirected_to depositos_path
  end
end
