require 'rails_helper'

RSpec.describe 'Homes', type: :system do
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
end
