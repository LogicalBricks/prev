require 'test_helper'

class DepositosControllerTest < ActionController::TestCase
  setup do
    @prevision = FactoryGirl.create :prevision, fecha_inicial: Date.current.yesterday, fecha_final: 10.days.from_now, monto: 100_000
    @deposito = FactoryGirl.create :deposito, prevision: @prevision, fecha: 1.day.from_now
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:depositos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create deposito" do
    assert_difference('Deposito.count') do
      post :create, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should create deposito that pays commisions" do
    comision = FactoryGirl.create :comision, prevision: @prevision
    assert_difference('Deposito.count') do
      post :create, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id, pago_de_comisiones_o_impuestos: true, comision_ids: [comision.id] }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should create deposito that pays taxes" do
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 100, prevision: @prevision
    gasto = FactoryGirl.create :gasto, socio: socio, apartado: FactoryGirl.create(:apartado, prevision: @prevision)
    assert_difference('Deposito.count') do
      post :create, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id, pago_de_comisiones_o_impuestos: true, gasto_ids: [gasto.id] }
    end

    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should not create deposito that includes gasto but doesn not pay taxes" do
    socio = FactoryGirl.create :socio, :con_tope, monto_tope: 100, prevision: @prevision
    gasto = FactoryGirl.create :gasto, socio: socio, apartado: FactoryGirl.create(:apartado, prevision: @prevision)
    assert_difference('Deposito.count', 0) do
      post :create, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id, pago_de_comisiones_o_impuestos: false, gasto_ids: [gasto.id] }
    end

    assert_template :new
  end

  test "should show deposito" do
    get :show, id: @deposito
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @deposito
    assert_response :success
  end

  test "should update deposito" do
    patch :update, id: @deposito, deposito: { descripcion: @deposito.descripcion, fecha: @deposito.fecha, monto: @deposito.monto, prevision_id: @deposito.prevision_id }
    assert_redirected_to deposito_path(assigns(:deposito))
  end

  test "should destroy deposito" do
    assert_difference('Deposito.count', -1) do
      delete :destroy, id: @deposito
    end

    assert_redirected_to depositos_path
  end
end
