require 'test_helper'

class SociosControllerTest < ActionController::TestCase
  setup do
    @socio = socios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:socios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create socio" do
    assert_difference('Socio.count') do
      post :create, socio: { nombre: @socio.nombre, usuario_id: @socio.usuario_id }
    end

    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should show socio" do
    get :show, id: @socio
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @socio
    assert_response :success
  end

  test "should update socio" do
    patch :update, id: @socio, socio: { nombre: @socio.nombre, usuario_id: @socio.usuario_id }
    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should destroy socio" do
    assert_difference('Socio.count', -1) do
      delete :destroy, id: @socio
    end

    assert_redirected_to socios_path
  end
end
