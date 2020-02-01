require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get accounts_signup_path
    assert_response :success
  end

end
