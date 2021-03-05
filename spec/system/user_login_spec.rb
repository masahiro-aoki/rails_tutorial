require 'rails_helper'

RSpec.describe 'User login', type: :system do
  let!(:user) { create :user }

  context '正常なデータ' do
    it 'ログイン成功時にプロフィール画面が表示されること' do
      visit login_path
      expect(page).to have_title 'Log in | Ruby on Rails Tutorial Sample App'

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      expect(page).to_not have_content 'Log in'

      expect(page).to have_title "#{user.name} | Ruby on Rails Tutorial Sample App"
      expect(page).to have_content 'Log out'
      expect(page).to have_content 'Profile'
      expect(current_path).to eq "/users/#{user.id}"
    end
    it 'ログアウトを実行するとルート画面が表示されること' do
      visit login_path

      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      click_link 'Log out'
      expect(page).to have_content 'Log in'
      expect(current_path).to eq root_path

      expect(page).to_not have_title "#{user.name} | Ruby on Rails Tutorial Sample App"
      expect(page).to_not have_content 'Log out'
      expect(page).to_not have_content 'Profile'
    end
  end

  context '無効なデータ' do
    it 'ログイン失敗時にログイン画面が表示されること' do
      visit login_path
      expect(page).to have_content 'Log in'

      fill_in 'Email', with: ''
      fill_in 'Password', with: 'password'
      click_button 'Log in'

      expect(page).to have_title 'Log in | Ruby on Rails Tutorial Sample App'
      expect(page).to have_content 'Invalid email/password combination'
      expect(current_path).to eq login_path
    end
  end
end
