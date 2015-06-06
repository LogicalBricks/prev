require 'test_helper'

class PrevisionesControllerTest < ActionController::TestCase
  setup do
    @prevision = FactoryGirl.create :prevision, fecha_inicial: Date.today, fecha_final: Date.today + 1.days
    @rubro = FactoryGirl.create :rubro
    @socio = FactoryGirl.create :socio, usuario: FactoryGirl.create(:usuario)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:previsiones)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create prevision" do
    assert_difference('Prevision.count') do
      post :create, prevision: { fecha_final: @prevision.fecha_final, fecha_inicial: @prevision.fecha_inicial, monto: @prevision.monto }
    end

    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should create apartados" do
    assert_difference("Apartado.count") do
      post :create, prevision: {
        fecha_final: @prevision.fecha_final,
        fecha_inicial: @prevision.fecha_inicial,
        monto: @prevision.monto,
        apartados_attributes: [ { rubro_id: @rubro.id, monto_maximo: 1000 } ],
        topes_attributes: [ { socio_id: @socio.id, monto: 500 } ]
      }
    end
  end

  test "should create topes" do
    assert_difference("Tope.count") do
      post :create, prevision: {
        fecha_final: @prevision.fecha_final,
        fecha_inicial: @prevision.fecha_inicial,
        monto: @prevision.monto,
        apartados_attributes: [ { rubro_id: @rubro.id, monto_maximo: 1000 } ],
        topes_attributes: [ { socio_id: @socio.id, monto: 500 } ]
      }
    end
  end

  test "should show prevision" do
    get :show, id: @prevision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @prevision
    assert_response :success
  end

  test "should update prevision" do
    patch :update, id: @prevision, prevision: { fecha_final: @prevision.fecha_final, fecha_inicial: @prevision.fecha_inicial, monto: @prevision.monto }
    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should destroy prevision" do
    assert_difference('Prevision.count', -1) do
      delete :destroy, id: @prevision
    end

    assert_redirected_to previsiones_path
  end
end
