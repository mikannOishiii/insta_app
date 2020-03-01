require 'rails_helper'

RSpec.feature "UserEdits", type: :feature do
  let(:user) { FactoryBot.create(:user) }

  scenario "successful edit with friendly forwarding" do
    visit edit_user_path(user)
    valid_login(user)

    expect(current_path).to eq edit_user_path(user)
  end
end
