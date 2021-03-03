require 'rails_helper'

RSpec.describe 'User login', type: :system do
  it '正常なデータでログインを実行後ログアウトをする' do
    create :user

    visit login_path
    expect(page).to have_content 'Log in'

    fill_in "Email", with: "tester@example.com"
    fill_in "Password", with: "password"
    click_button "Log in"
    expect(page).to_not have_content "Log in"

    expect(page).to have_content "foo bar"
    expect(page).to have_content "Log out"
    expect(page).to have_content "Profile"

    click_link "Log out"
    expect(page).to have_content "Log in"
    expect(page).to_not have_content "foo bar"
    expect(page).to_not have_content "Log out"
    expect(page).to_not have_content "Profile"
  end
end
