require 'rails_helper'

RSpec.feature "Users", type: :feature do
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
end
