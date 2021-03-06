require 'test_helper'

class RubrosControllerTest < ActionController::TestCase
  setup do
    @rubro = FactoryGirl.create :rubro
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rubros)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rubro" do
    assert_difference('Rubro.count') do
      post :create, params: {
        rubro: { descripcion: @rubro.descripcion, nombre: @rubro.nombre }
      }
    end

    assert_redirected_to rubro_path(assigns(:rubro))
  end

  test "should show rubro" do
    get :show, params: { id: @rubro }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @rubro }
    assert_response :success
  end

  test "should update rubro" do
    patch :update, params: {
      id: @rubro, rubro: { descripcion: @rubro.descripcion, nombre: @rubro.nombre }
    }
    assert_redirected_to rubro_path(assigns(:rubro))
  end

  test "should destroy rubro" do
    assert_difference('Rubro.count', -1) do
      delete :destroy, params: { id: @rubro }
    end

    assert_redirected_to rubros_path
  end
end
