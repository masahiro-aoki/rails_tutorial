require 'rails_helper'

RSpec.describe 'User signup', type: :system do
  context '有効なユーザー' do
    it '新規にユーザーが作成されること' do
      visit signup_path
      expect(page).to have_content 'Sign up'

      expect {
        fill_in 'Name', with: 'foo bar'
        fill_in 'Email', with: 'tester@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirmation', with: 'password'
        click_button 'Create my account'
      }.to change(User, :count).by(1)
    end
  end

  context '無効なユーザー' do
    it '新規ユーザーが作成されずsignup画面が表示される' do
      visit signup_path
      expect(page).to have_content 'Sign up'

      expect {
        fill_in 'Name', with: ''
        fill_in 'Email', with: 'tester@example.com'
        fill_in 'Password', with: 'password'
        fill_in 'Confirmation', with: 'password'
        click_button 'Create my account'

        expect(page).to have_selector '#error_explanation', text: "Name can't be blank"

        expect(page).to have_content 'Log in'

        expect(page).to_not have_content 'foo bar'
        expect(page).to_not have_content 'Log out'
        expect(page).to_not have_content 'Profile'
      }.to change(User, :count).by(0)

      expect(page).to have_title 'Sign Up | Ruby on Rails Tutorial Sample App'
    end
  end

end
