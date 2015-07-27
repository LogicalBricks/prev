require 'test_helper'

class SociosControllerTest < ActionController::TestCase
  setup do
    @socio = FactoryGirl.create :socio, usuario: FactoryGirl.build(:usuario)
    FactoryGirl.create(:tope, socio: @socio)
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
      post :create, socio: {
        nombre: @socio.nombre,
        usuario_attributes: @usuario_attributes
      }
    end

    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should create usuario" do
    assert_difference('Usuario.count') do
      post :create, socio: {
        nombre: @socio.nombre,
        usuario_attributes: @usuario_attributes
      }
    end

    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should create usuario with rol socio" do
    post :create, socio: {
      nombre: @socio.nombre,
      usuario_attributes: @usuario_attributes
    }

    assert_equal 'socio', assigns(:socio).usuario.rol
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
    usuario = @socio.usuario
    patch :update, id: @socio, socio: {
      nombre: @socio.nombre + '1'
    }
    assert_redirected_to socio_path(assigns(:socio))
  end

  test "should destroy socio" do
    assert_difference('Socio.count', -1) do
      delete :destroy, id: @socio
    end

    assert_redirected_to socios_path
  end
end
