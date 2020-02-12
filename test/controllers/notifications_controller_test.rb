require 'test_helper'

class NotificationsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test "should redirect index when not logged in" do
    get notifications_path(@user)
    assert_not flash.empty?
    assert_redirected_to accounts_login_url
  end

end
