require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", user_name: "User Name 001",
              password: "foobar", password_confirmation: "foobar")
    extend ActionDispatch::TestProcess
    @uploaded_file = fixture_file_upload('images/sample.jpg', 'image/jpeg')
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end

  test "user_name should be present" do
    @user.user_name = "     "
    assert_not @user.valid?
  end
  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "user_name should not be too long" do
    @user.user_name = "a" * 51
    assert_not @user.valid?
  end

  test "user_name should be unique" do
    duplicate_user = @user.dup
    duplicate_user.user_name = @user.user_name.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(picture: @uploaded_file)
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    michael = users(:michael)
    archer  = users(:archer)
    assert_not michael.following?(archer)
    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)
    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "feed should have the right posts" do
    michael = users(:michael)
    archer  = users(:archer)
    lana    = users(:lana)
    # フォローしているユーザーの投稿を確認
    lana.posts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # 自分自身の投稿を確認
    michael.posts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # フォローしていないユーザーの投稿を確認
    archer.posts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end

  test "should like and unlike a post" do
    michael = users(:michael)
    ants  = posts(:ants)
    assert_not michael.like?(ants)
    michael.like(ants)
    assert michael.like?(ants)
    assert michael.fav_lists.include?(ants)
    michael.unlike(ants)
    assert_not michael.like?(ants)
  end

  test "associated microposts should be destroyed" do
    malory = users(:malory)
    ants  = posts(:ants)
    malory.comments.create!(content: "Lorem ipsum", post_id: ants.id )
    assert_difference 'Comment.count', -1 do
      malory.destroy
    end
  end

  test "should notification and follow a user" do
    michael = users(:michael)
    archer  = users(:archer)
    michael.follow(archer)
    archer.create_notification_follow(michael)
    assert archer.follower_notice.include?(michael)
  end
end
