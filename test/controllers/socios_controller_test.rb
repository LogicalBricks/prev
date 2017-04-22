require 'test_helper'

class SociosControllerTest < ActionController::TestCase
  setup do
    @socio = FactoryGirl.create :socio, :con_tope
    @usuario_attributes = { email: 'usuario@mail.com', password: 'abcd1234', password_confirmation: 'abcd1234' }
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

  test "should build new usuario" do
    get :new
    assert_not_nil assigns(:socio).usuario
  end

  test "should create socio" do
    assert_difference('Socio.count') do
      post :create, params: {
        socio: {
          nombre: @socio.nombre,
          usuario_attributes: @usuario_attributes
        }
      }
    end

    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should create usuario" do
    assert_difference('Usuario.count') do
      post :create, params: {
        socio: {
          nombre: @socio.nombre,
          usuario_attributes: @usuario_attributes
        }
      }
    end

    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should create usuario with rol socio" do
    post :create, params: {
      socio: {
        nombre: @socio.nombre,
        usuario_attributes: @usuario_attributes
      }
    }

    assert_equal 'socio', assigns(:socio).usuario.rol
  end

  test "should show socio" do
    get :show, id: @socio
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @socio.id }
    assert_response :success
  end

  test "should update socio" do
    usuario = @socio.usuario
    patch :update, params: {
      id: @socio.id,
      socio: {
        nombre: @socio.nombre + '1'
      }
    }
    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should destroy socio" do
    assert_difference('Socio.count', -1) do
      delete :destroy, params: { id: @socio.id }
    end

    assert_redirected_to socios_path
  end
end
