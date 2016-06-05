require 'test_helper'

class PrevisionActivasControllerTest < ActionController::TestCase
  setup do
    @prevision = FactoryGirl.create :prevision, activa: false
    request.env["HTTP_REFERER"] = "previous_page"
  end

  test "should activate a prevision" do
    put :update, id: @prevision
    assert_equal @prevision.id, session[:prevision_actual_id]
  end

  test 'should redirect to the previous page' do
    put :update, id: @prevision
    assert_redirected_to "previous_page"
  end
end
