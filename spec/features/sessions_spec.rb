require 'rails_helper'

RSpec.feature "Sessions", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  
  scenario "invalid login information" do
    visit accounts_login_path
    fill_in "session_user_name", with: ''
    fill_in "session_password", with: ''
    click_button "ログインする"

    expect(page).to have_css "div.alert-danger"
    expect(current_path).to eq accounts_login_path
  end

  scenario "valid login information" do
    valid_login(user)

    expect(current_path).to eq user_path(user)
    expect(page).to_not have_content "ログイン"

    visit edit_user_path(user)
    click_link "ログアウト"

    expect(current_path).to eq root_path
    expect(page).to have_content "ログイン"
  end
end
