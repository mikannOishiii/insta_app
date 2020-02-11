require 'test_helper'

class CommentsInterfaceTest < ActionDispatch::IntegrationTest
  # def setup
  #   @user = users(:michael)
  #   @post = posts(:ants)
  # end

  # test "comment interface" do
  #   log_in_as(@user)
  #   get post_comments_path(@post)
  #   assert_template 'comments/index'
  #   # 無効な送信
  #   assert_no_difference 'Comment.count' do
  #     post comment_path, params: { comment: { content: "" } }
  #   end
  #   assert_select 'div#error_explanation'
  #   # 有効な送信
  #   content = "This micropost really ties the room together"
  #   assert_difference 'Micropost.count', 1 do
  #     post microposts_path, params: { micropost: { content: content } }
  #   end
  #   assert_redirected_to root_url
  #   follow_redirect!
  #   assert_match content, response.body
  #   # 投稿を削除する
  #   assert_select 'a', text: 'delete'
  #   first_micropost = @user.microposts.paginate(page: 1).first
  #   assert_difference 'Micropost.count', -1 do
  #     delete micropost_path(first_micropost)
  #   end
  #   # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
  #   get user_path(users(:archer))
  #   assert_select 'a', text: 'delete', count: 0
  # end
end
