require 'rails_helper'

RSpec.describe 'User index', type: :system do
  let(:user) { create :user }


  it "ページネーションが表示されること" do
    1.upto(30) do |num|
      create :user, name: "test user#{num}", email: "test#{num}@example.com", password: 'password', password_confirmation: "password"
    end

    log_in_as user
    visit users_path

    expect(page).to have_title 'All users | Ruby on Rails Tutorial Sample App'
    expect(page).to have_css 'ul.pagination', count: 2
    User.paginate(page: 1).each do |user|
      expect(page).to have_link href:user_path(user)
      expect(page).to have_content user.name
    end
  end

  # it 'データが更新されること' do
  #   log_in_as user
  #   visit edit_user_path user

  #   name  = 'Foo Bar'
  #   email = 'foo@bar.com'

  #   fill_in 'Name', with: name
  #   fill_in 'Email', with: email
  #   fill_in 'Password', with: ''
  #   fill_in 'Confirmation', with: ''
  #   click_button 'Save changes'

  #   expect(current_path).to eq user_path user
  #   expect(page).to have_content 'Profile updated'
  #   user.reload
  #   expect(name).to eq  user.name
  #   expect(email).to eq user.email
  # end

  # context '無効なデータ' do
  #   it 'データが更新されないこと' do
  #     log_in_as user
  #     visit edit_user_path user

  #     fill_in 'Name', with: ''
  #     fill_in 'Email', with: user.password
  #     fill_in 'Password', with: user.password
  #     fill_in 'Confirmation', with: user.password
  #     click_button 'Save changes'

  #     expect(user.name).to_not eq ''
  #     expect(page).to have_content "Name can't be blank"
  #   end
  # end
end
