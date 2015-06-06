require 'test_helper'

class TopesControllerTest < ActionController::TestCase
  setup do
    @tope = topes(:one)
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
      post :create, tope: { monto: @tope.monto, prevision_id: @tope.prevision_id, socio: @tope.socio, socio_id: @tope.socio_id }
    end

    assert_redirected_to tope_path(assigns(:tope))
  end

  test "should show tope" do
    get :show, id: @tope
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tope
    assert_response :success
  end

  test "should update tope" do
    patch :update, id: @tope, tope: { monto: @tope.monto, prevision_id: @tope.prevision_id, socio: @tope.socio, socio_id: @tope.socio_id }
    assert_redirected_to tope_path(assigns(:tope))
  end

  test "should destroy tope" do
    assert_difference('Tope.count', -1) do
      delete :destroy, id: @tope
    end

    assert_redirected_to topes_path
  end
end
