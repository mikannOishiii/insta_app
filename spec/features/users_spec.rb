require 'rails_helper'

RSpec.feature "Users", type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:another_user) { FactoryBot.create(:another_user) }

  scenario "invalid signup information" do
    visit accounts_signup_path
    expect {
      fill_in "user_name", with: 'Example User'
      fill_in "user_user_name", with: 'example'
      fill_in "user_password", with: 'foo'
      fill_in "user_password_confirmation", with: 'bar'
      click_button "登録する"

      expect(page).to have_css "div#error_explanation"
      expect(page).to have_css "div.field_with_errors"
    }.not_to change(User, :count)
  end

  scenario "valid signup information" do
    visit accounts_signup_path
    expect {
      fill_in "user_name", with: 'Example User'
      fill_in "user_user_name", with: 'example'
      fill_in "user_password", with: 'foobar'
      fill_in "user_password_confirmation", with: 'foobar'
      click_button "登録する"

      expect(page).to have_css "div.alert-success"
    }.to change(User, :count).by(1)
  end

  scenario "unsuccessful edit" do
    valid_login(user)
    visit edit_user_path(user)

    fill_in "user_user_name", with: ''
    click_button "送信する"

    expect(page).to have_css "div#error_explanation"
    expect(page).to have_css "div.field_with_errors"
    expect(current_path).to eq user_path(user)
  end

  scenario "successful edit" do
    valid_login(user)
    visit edit_user_path(user)

    fill_in "user_user_name", with: 'example edittest'
    click_button "送信する"

    expect(page).to have_css "div.alert-success"
    expect(page).to have_content "example edittest"
    expect(current_path).to eq user_path(user)
  end
end
