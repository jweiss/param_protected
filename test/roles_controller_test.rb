require File.dirname(__FILE__) + "/test_helper"

class RolesControllerTest < ActionController::TestCase
  def test_dont_filter_controller_action_and_id
    get :update, :id => 1
    assert_equal "1", params[:id]
    assert_equal "update", params[:action]
    assert_equal "roles", params[:controller]
  end
  
end
