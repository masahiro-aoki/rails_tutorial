require 'rails_helper'

RSpec.describe "Sessions Helper", type: :helper do
  include SessionsHelper
  let(:user) { create :user }

  it "current_userはsessionがnilの場合に正しいユーザーを返すこと" do
    remember(user)
    expect(user).to eq current_user
  end

  it "remember_digestが間違っている場合にcurrent_userがnilを返すこと" do
    remember(user)
    user.update_attribute(:remember_digest, User.digest(User.new_token))
    expect(current_user).to be_nil
  end
end
