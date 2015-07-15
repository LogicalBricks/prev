require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  test 'should render no_socio when no socio is in the system' do
    get :index
    assert_template 'no_socio' 
  end

  test 'should render no_rubro when no rubro is in the system' do
    FactoryGirl.create :socio
    get :index
    assert_template 'no_rubro' 
  end

  test 'should render no_prevision when no prevision is in the system' do
    FactoryGirl.create :socio
    FactoryGirl.create :rubro
    get :index
    assert_template 'no_prevision' 
  end

  test 'should render no_deposito when no deposito is in the system' do
    FactoryGirl.create :socio
    FactoryGirl.create :rubro
    FactoryGirl.create :prevision
    get :index
    assert_template 'no_deposito' 
  end

  test "should get estado_cuenta" do
    FactoryGirl.create :prevision
    get :estado_cuenta
    assert_response :success
  end

end
