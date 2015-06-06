require 'test_helper'

class GastosControllerTest < ActionController::TestCase
  setup do
    @gasto = gastos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gastos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gasto" do
    assert_difference('Gasto.count') do
      post :create, gasto: { apartado_id: @gasto.apartado_id, descripcion: @gasto.descripcion, factura_pdf: @gasto.factura_pdf, factura_xml: @gasto.factura_xml, fecha: @gasto.fecha, metodo_pago: @gasto.metodo_pago, monto: @gasto.monto, proveedor_id: @gasto.proveedor_id, socio_id: @gasto.socio_id, solicitud: @gasto.solicitud }
    end

    assert_redirected_to gasto_path(assigns(:gasto))
  end

  test "should show gasto" do
    get :show, id: @gasto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gasto
    assert_response :success
  end

  test "should update gasto" do
    patch :update, id: @gasto, gasto: { apartado_id: @gasto.apartado_id, descripcion: @gasto.descripcion, factura_pdf: @gasto.factura_pdf, factura_xml: @gasto.factura_xml, fecha: @gasto.fecha, metodo_pago: @gasto.metodo_pago, monto: @gasto.monto, proveedor_id: @gasto.proveedor_id, socio_id: @gasto.socio_id, solicitud: @gasto.solicitud }
    assert_redirected_to gasto_path(assigns(:gasto))
  end

  test "should destroy gasto" do
    assert_difference('Gasto.count', -1) do
      delete :destroy, id: @gasto
    end

    assert_redirected_to gastos_path
  end
end
