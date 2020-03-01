# 新しいモジュールを作成
module LoginSupport
  def valid_login(user)
    visit accounts_login_path
    fill_in "session_user_name", with: user.user_name
    fill_in "session_password", with: user.password
    click_button "ログインする"
  end
end

# LoginSupportモジュールをincludeする
RSpec.configure do |config|
  config.include LoginSupport
end
