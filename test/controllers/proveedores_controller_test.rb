require 'test_helper'

class ProveedoresControllerTest < ActionController::TestCase
  setup do
    @proveedor = FactoryGirl.create :proveedor
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:proveedores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create proveedor" do
    assert_difference('Proveedor.count') do
      post :create, params: {
        proveedor: { nombre: @proveedor.nombre, rfc: @proveedor.rfc }
      }
    end

    assert_redirected_to proveedor_path(assigns(:proveedor))
  end

  test "should show proveedor" do
    get :show, params: { id: @proveedor }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @proveedor }
    assert_response :success
  end

  test "should update proveedor" do
    patch :update, params: {
      id: @proveedor, proveedor: { nombre: @proveedor.nombre, rfc: @proveedor.rfc }
    }
    assert_redirected_to proveedor_path(assigns(:proveedor))
  end

  test "should destroy proveedor" do
    assert_difference('Proveedor.count', -1) do
      delete :destroy, params: { id: @proveedor }
    end

    assert_redirected_to proveedores_path
  end
end
