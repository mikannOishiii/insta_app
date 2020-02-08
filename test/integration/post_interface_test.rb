require 'test_helper'

class PostInterfaceTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test "micropost interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    # 無効な送信
    # assert_no_difference 'Post.count' do
    #   post posts_path, params: { post: { picture: "" } }
    # end
    # assert_select 'div#error_explanation'
    # 有効な送信
    # extend ActionDispatch::TestProcess
    # uploaded_file = fixture_file_upload('images/sample.jpg', 'image/jpeg')
    # assert_difference 'Post.count', 1 do
    #   post posts_path, params: { post: { picture: uploaded_file } }
    # end
    # assert_redirected_to root_url
    # follow_redirect!
    # assert_match uploaded_file, response.body
    # 投稿を削除する
    assert_select 'a', picture: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # 違うユーザーのプロフィールにアクセス (削除リンクがないことを確認)
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
end
