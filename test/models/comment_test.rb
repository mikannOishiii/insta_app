require 'test_helper'

class CommentTest < ActiveSupport::TestCase

  def setup
    @user = users(:michael)
    @post = posts(:zone)
  end

  def setup
    @user = users(:michael)
    @post = posts(:orange)
    @comment = @user.comments.build(content: "test comment", post_id: @post.id)
    # このコードは慣習的に正しくない
    # @comment = Comment.new(content: "test comment", user_id: @user.id, post_id: @post.id)
  end

  test "should be valid" do
    assert @comment.valid?
  end

  test "user id should be present" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
end
