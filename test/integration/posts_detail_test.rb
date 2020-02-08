require 'test_helper'

class PostsDetailTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @post = posts(:ants)
  end
  
  test "post detail interface" do
    log_in_as(@user)
    get post_path(@post)
    assert_template 'posts/show'
    # assert_select 'title', full_title(@user.name)
    # assert_select 'h1', text: @user.user_name
    # assert_select 'h1>img.gravatar'
    # assert_match @post.comments.count.to_s, response.body
    # assert_select 'div.pagination'
    # @user.posts.paginate(page: 1).each do |post|
    #   assert_match post.picture, response.body
    # end

  end
end
