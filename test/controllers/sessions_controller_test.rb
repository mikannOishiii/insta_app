require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get accounts_login_path
    assert_response :success
  end

end
