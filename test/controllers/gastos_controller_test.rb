require 'test_helper'

class GastosControllerTest < ActionController::TestCase
  setup do
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
      apartado = FactoryGirl.create :apartado
      socio = FactoryGirl.create :socio
      tope = FactoryGirl.create :tope, socio: socio
      params = {
        apartado_id: apartado.id,
        descripcion: "Una descripción",
        fecha:       Date.today,
        metodo_pago: "efectivo",
        monto:       "10",
        socio_id:    socio.id
      }
      post :create, gasto: params
    end

    assert_redirected_to gasto_path(assigns(:gasto))
  end

  test "should not save gasto when rebasing socios monto" do
    assert_no_difference('Gasto.count') do
      apartado = FactoryGirl.create :apartado
      socio = FactoryGirl.create :socio
      tope = FactoryGirl.create :tope, socio: socio, monto: 9
      params = {
        apartado_id: apartado.id,
        descripcion: "Una descripción",
        fecha:       Date.today,
        metodo_pago: "efectivo",
        monto:       "10",
        socio_id:    socio.id
      }
      post :create, gasto: params
    end
    assert_equal 1, assigns(:gasto).errors[:forzar_monto].size
    assert assigns(:gasto).supera_monto_socio?

    assert_template :new
  end

  test "should save gasto when rebasing socios monto but forzar_monto flag is set" do
    assert_difference('Gasto.count') do
      apartado = FactoryGirl.create :apartado
      socio = FactoryGirl.create :socio
      tope = FactoryGirl.create :tope, socio: socio, monto: 9
      params = {
        apartado_id: apartado.id,
        descripcion: "Una descripción",
        fecha:       Date.today,
        metodo_pago: "efectivo",
        monto:       "10",
        socio_id:    socio.id,
        forzar_monto: "1",
      }
      post :create, gasto: params
    end
    assert_redirected_to gasto_path(assigns(:gasto))
  end

  test "should show gasto" do
    tope = FactoryGirl.create :tope
    get :show, id: FactoryGirl.create(:gasto, socio: FactoryGirl.create(:tope).socio)
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: FactoryGirl.create(:gasto, socio: FactoryGirl.create(:tope).socio)
    assert_response :success
  end

  test "should update gasto" do
    gasto = FactoryGirl.create :gasto, socio: FactoryGirl.create(:tope).socio
    patch :update, id: gasto, gasto: { apartado_id: gasto.apartado_id, descripcion: gasto.descripcion, factura_pdf: gasto.factura_pdf, factura_xml: gasto.factura_xml, fecha: gasto.fecha, metodo_pago: gasto.metodo_pago, monto: gasto.monto, proveedor_id: gasto.proveedor_id, socio_id: gasto.socio_id, solicitud: gasto.solicitud }
    assert_redirected_to gasto_path(assigns(:gasto))
  end

  test "should destroy gasto" do
    gasto = FactoryGirl.create :gasto, socio: FactoryGirl.create(:tope).socio
    assert_difference('Gasto.count', -1) do
      delete :destroy, id: gasto
    end

    assert_redirected_to gastos_path
  end
end
