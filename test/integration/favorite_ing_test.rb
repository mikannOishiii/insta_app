require 'test_helper'

class FavoriteIngTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:ants)
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

  test "should favorite a post the standard way" do
    assert_difference '@user.fav_lists.count', 1 do
      post favorites_path, params: { post_id: @post.id }
    end
  end

  # test "should favorite a post with Ajax" do
  #   assert_difference '@user.favorites.count', 1 do
  #     post favorites_path, xhr: true, params: { post_id: @post.id }
  #   end
  # end

  test "should destroy favorite a post the standard way" do
    @user.like(@post)
    favorite = @user.favorites.find_by(post_id: @post.id)
    assert_difference '@user.favorites.count', -1 do
      delete favorite_path(favorite)
    end
  end

  # test "should unfollow a user with Ajax" do
  #   @user.like(@post)
  #   favorite = @user.favorites.find_by(post_id: @post.id)
  #   assert_difference '@user.favorites.count', -1 do
  #     delete favorite_path(favorite), xhr: true
  #   end
  # end
end
