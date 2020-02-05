require 'test_helper'

class FavoritesControllerTest < ActionDispatch::IntegrationTest

  test "create should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      post favorites_path
    end
    assert_redirected_to accounts_login_url
  end

  test "destroy should require logged-in user" do
    assert_no_difference 'Favorite.count' do
      delete favorite_path(relationships(:one))
    end
    assert_redirected_to accounts_login_url
  end

end
