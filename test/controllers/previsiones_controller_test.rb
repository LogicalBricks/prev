require 'test_helper'

class PrevisionesControllerTest < ActionController::TestCase
  setup do
    @prevision = FactoryGirl.create :prevision, monto_presupuestado: 100_000
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

  test "should load an new tope" do
    get :new
    refute_empty assigns(:prevision).topes
  end

  test "should load an new apartado" do
    get :new
    refute_empty assigns(:prevision).apartados
  end

  test "should create prevision" do
    assert_difference('Prevision.count') do
      post :create, prevision: { periodo: @prevision.periodo, monto_presupuestado: @prevision.monto_presupuestado }
    end

    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should create apartados" do
    assert_difference("Apartado.count") do
      post :create, prevision: {
        periodo: @prevision.periodo,
        monto_presupuestado: @prevision.monto_presupuestado,
        apartados_attributes: [ { rubro_id: @rubro.id, monto_maximo: 1000 } ],
        topes_attributes: [ { socio_id: @socio.id, monto: 500 } ]
      }
    end
  end

  test "should create topes" do
    assert_difference("Tope.count") do
      post :create, prevision: {
        periodo: @prevision.periodo,
        monto_presupuestado: @prevision.monto_presupuestado,
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
    patch :update, id: @prevision, prevision: { periodo: @prevision.periodo, monto_presupuestado: @prevision.monto_presupuestado }
    assert_redirected_to prevision_path(assigns(:prevision))
  end

  test "should remove apartados" do
    @prevision.apartados << FactoryGirl.build(:apartado, rubro: @rubro, monto_maximo: 500)
    @prevision.topes << FactoryGirl.build(:tope, socio: @socio, monto: 1000)
    assert_difference("Apartado.count", -1) do
      patch :update, id: @prevision.id, prevision: {
        apartados_attributes: [ { id: @prevision.apartados.first.id, monto_maximo: 500, _destroy: 1 } ],
        topes_attributes: [ { id: @prevision.topes.first.id, monto: 1000, _destroy: 1 } ]
      }
    end
  end

  test "should remove topes" do
    @prevision.apartados << FactoryGirl.build(:apartado, rubro: @rubro, monto_maximo: 500)
    @prevision.topes << FactoryGirl.build(:tope, socio: @socio, monto: 1000)
    assert_difference("Tope.count", -1) do
      patch :update, id: @prevision.id, prevision: {
        apartados_attributes: [ { id: @prevision.apartados.first.id, monto_maximo: 500, _destroy: 1 } ],
        topes_attributes: [ { id: @prevision.topes.first.id, monto: 1000, _destroy: 1 } ]
      }
    end
  end

  test "should destroy prevision" do
    assert_difference('Prevision.count', -1) do
      delete :destroy, id: @prevision
    end

    assert_redirected_to previsiones_path
  end
end
