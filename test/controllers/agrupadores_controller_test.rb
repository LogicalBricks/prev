require 'test_helper'

class AgrupadoresControllerTest < ActionController::TestCase
  setup do
    @agrupador = FactoryGirl.create :agrupador
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:agrupadores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create agrupador" do
    assert_difference('Agrupador.count') do
      post :create, agrupador: { nombre: @agrupador.nombre }
    end

    assert_redirected_to agrupador_path(assigns(:agrupador))
  end

  test "should show agrupador" do
    get :show, id: @agrupador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @agrupador
    assert_response :success
  end

  test "should update agrupador" do
    patch :update, id: @agrupador, agrupador: { nombre: @agrupador.nombre }
    assert_redirected_to agrupador_path(assigns(:agrupador))
  end

  test "should destroy agrupador" do
    assert_difference('Agrupador.count', -1) do
      delete :destroy, id: @agrupador
    end

    assert_redirected_to agrupadores_path
  end
end
