require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  describe '未ログイン時' do
    it 'リンクが表示されること' do
      visit root_path
      expect(page).to have_content 'Welcome to the Sample App'

      expect(page).to have_link 'sample app', href: '/'
      expect(page).to have_link 'Sign up now!', href: '/signup'
      expect(page).to have_link 'Home', href: '/'
      expect(page).to have_link 'Help', href: '/help'
      expect(page).to have_link 'Log in', href: '/login'
      expect(page).to have_link 'About', href: '/about'
      expect(page).to have_link 'Contact', href: '/contact'
    end

    it '各リンクの遷移先が正しいこと' do
      visit root_path
      expect(current_path).to eq root_path
      expect(page).to have_content 'Welcome to the Sample App'

      click_link 'sample app'
      expect(current_path).to eq root_path
      expect(page).to have_content 'Welcome to the Sample App'

      click_link 'Sign up now!'
      expect(current_path).to eq signup_path
      expect(page).to have_title 'Sign Up | Ruby on Rails Tutorial Sample App'

      click_link 'Home'
      expect(current_path).to eq root_path
      expect(page).to have_title 'Ruby on Rails Tutorial Sample App'

      click_link 'Help'
      expect(current_path).to eq help_path
      expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'

      click_link 'Log in'
      expect(current_path).to eq login_path
      expect(page).to have_title 'Log in | Ruby on Rails Tutorial Sample App'

      click_link 'About'
      expect(current_path).to eq about_path
      expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'

      click_link 'Contact'
      expect(current_path).to eq contact_path
      expect(page).to have_title 'Contact | Ruby on Rails Tutorial Sample App'
    end
  end

  describe 'ログイン時' do
    it 'リンクが表示されること' do
      user = create :user
      log_in_as user
      visit root_path

      expect(page).to have_link 'Users', href: '/users'
      expect(page).to have_link 'Account', href: '#'
      expect(page).to have_link 'Profile', href: "/users/#{user.id}"
      expect(page).to have_link 'Settings', href: "/users/#{user.id}/edit"
      expect(page).to have_link 'Log out', href: '/logout'
    end

    it '各リンクの遷移先が正しいこと' do
      user = create :user
      log_in_as user
      visit root_path

      click_link 'Users'
      expect(current_path).to eq users_path
      expect(page).to have_title 'All users | Ruby on Rails Tutorial Sample App'
    end
  end

end
