require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @comment = comments(:comfoo)
    @post = posts(:ants)  
  end

  test "should redirect create when not logged in" do
    assert_no_difference 'Comment.count' do
      post post_comments_path(@post), params: { comment: { content: "Lorem ipsum" } }
    end
    assert_redirected_to accounts_login_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'Comment.count' do
      delete post_comment_path(@post, @comment)
    end
    assert_redirected_to accounts_login_url
  end

  test "should redirect destroy for wrong comment" do
    log_in_as(users(:lana))
    comment = comments(:comfoo) 
    assert_no_difference 'Comment.count' do
      delete post_comment_path(@post, comment)
    end
    assert_redirected_to root_url
  end
end
