require File.dirname(__FILE__) + "/test_helper"

class ForgeryControllerTest < ActionController::TestCase
  def test_dont_filter_authenticity_token
    get :create, :custom_auth_token => '12345'
    assert_equal '12345', params[:custom_auth_token]
  end
end