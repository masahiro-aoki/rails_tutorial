require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  it 'リンクが正常であること' do
    visit root_path
    expect(page).to have_content 'Welcome to the Sample App'

    expect(page).to have_link 'sample app', href: '/'
    expect(page).to have_link 'Sign up now!', href: '/signup'
    expect(page).to have_link 'Home', href: '/'
    expect(page).to have_link 'Help', href: '/help'
    expect(page).to have_link 'About', href: '/about'
    expect(page).to have_link 'Contact', href: '/contact'
    # click_link '管理者アカウント発行'
    # fill_in 'メールアドレス', with: 'admin@example.com'
    # fill_in 'パスワード(必須)', with: 'password'
    # fill_in 'パスワード（確認用）(必須)', with: 'password'
    # fill_in '姓', with: '管理'
    # fill_in '名', with: '太郎'
    # click_button '登録する'
    # expect(page).to have_content 'FP管理者アカウントを作成しました。'
    # expect(page).to have_content 'admin@example.com'
    # expect(page).to have_content '管理 太郎'
  end
end
