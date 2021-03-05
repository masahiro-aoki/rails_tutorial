require 'rails_helper'

RSpec.describe 'User edit', type: :system do
  let(:user) { create :user }

  context '有効なデータ' do
    it 'データが更新されること' do
      log_in_as user
      visit edit_user_path user

      name  = 'Foo Bar'
      email = 'foo@bar.com'

      fill_in 'Name', with: name
      fill_in 'Email', with: email
      fill_in 'Password', with: ''
      fill_in 'Confirmation', with: ''
      click_button 'Save changes'

      expect(current_path).to eq user_path user
      expect(page).to have_content 'Profile updated'
      user.reload
      expect(name).to eq  user.name
      expect(email).to eq user.email
    end
  end

  context '無効なデータ' do
    it 'データが更新されないこと' do
      log_in_as user
      visit edit_user_path user

      fill_in 'Name', with: ''
      fill_in 'Email', with: user.password
      fill_in 'Password', with: user.password
      fill_in 'Confirmation', with: user.password
      click_button 'Save changes'

      expect(user.name).to_not eq ''
      expect(page).to have_content "Name can't be blank"
    end
  end
end
