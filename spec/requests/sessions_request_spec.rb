require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  let(:user) { create :user }

  describe 'POST /create' do
    it 'ログイン時にremember_meが1の場合はセッションが永続化されていること' do
      login user
      expect(cookies['remember_token']).to_not be_nil
    end
    it 'ログイン時にremember_meが0の場合はセッションが永続化されていないこと' do
      login user, remember_me: '0'
      expect(cookies['remember_token']).to be_nil
    end
  end
end
