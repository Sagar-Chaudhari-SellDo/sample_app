require 'test_helper'

class AccountActivationControllerTest < ActionController::TestCase
  test "should get password_reset" do
    get :password_reset
    assert_response :success
  end

end
