require 'test_helper'

class FavoriteIngTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as(@user)
  end

  test "favorite page" do
    get fav_lists_user_path(@user)
    assert_not @user.fav_lists.empty?
    assert_match @user.fav_lists.count.to_s, response.body
    @user.fav_lists.each do |post|
      assert_select "li#post-#{post.id}"
    end
  end
end
