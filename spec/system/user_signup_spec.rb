require 'rails_helper'

RSpec.describe 'User signup', type: :system do
  it '新規ユーザー作成処理' do
    visit signup_path
    expect(page).to have_content 'Sign up'

    expect {
      fill_in "Name", with: "foo bar"
      fill_in "Email", with: "tester@example.com"
      fill_in "Password", with: "password"
      fill_in "Confirmation", with: "password"
      click_button "Create my account"
      expect(page).to have_content "Welcome to the Sample App!"
      expect(page).to_not have_content "Log in"

      expect(page).to have_content "foo bar"
      expect(page).to have_content "Log out"
      expect(page).to have_content "Profile"
    }.to change(User, :count).by(1)
  end
end
