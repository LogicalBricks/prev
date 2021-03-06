require 'test_helper'

class TopesControllerTest < ActionController::TestCase
  setup do
    @tope = FactoryGirl.create :tope
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tope" do
    assert_difference('Tope.count') do
      post :create, params: {
        tope: { monto: @tope.monto, prevision_id: @tope.prevision_id, socio_id: @tope.socio_id }
      }
    end

    assert_redirected_to tope_path(assigns(:tope))
  end

  test "should show tope" do
    get :show, params: { id: @tope }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @tope }
    assert_response :success
  end

  test "should update tope" do
    patch :update, params: {
      id: @tope, tope: { monto: @tope.monto, monto_reservado: 1, prevision_id: @tope.prevision_id, socio_id: @tope.socio_id }
    }
    assert_redirected_to tope_path(assigns(:tope))
  end

  test "should destroy tope" do
    assert_difference('Tope.count', -1) do
      delete :destroy, params: { id: @tope }
    end

    assert_redirected_to topes_path
  end
end
