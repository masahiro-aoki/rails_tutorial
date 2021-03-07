require 'rails_helper'

RSpec.describe User, type: :model do
  context 'モデルが有効の場合' do
    it 'name, emailがあれば有効であること' do
      user = build :user, name: 'foo', email: 'tester@example.com'
      expect(user).to be_valid
    end
    it '有効なアドレスはemailのバリデーションチェックで有効となること' do
      user = build :user
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid, "#{valid_address.inspect} should be valid"
      end
    end
    it "メールアドレスが小文字で保存されること" do
      mixed_case_email = "Foo@ExAMPle.CoM"
      user = create :user, email: mixed_case_email
      expect(user.reload.email).to eq mixed_case_email.downcase
    end
    it "remember_digestがnilのユーザーはfalseを返すこと" do
      user = create :user
      expect(user.authenticated?(:remember, '')).to eq false
    end
  end

  context 'モデルが無効の場合' do
    it 'nameが無ければ無効であること' do
      user = build :user, name: nil, email: 'tester@example.com'
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
    end
    it 'nameが空文字の場合は無効であること' do
      user = build :user, name: '', email: 'tester@example.com'
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
    end
    it 'nameが空白の場合は無効であること' do
      user = build :user, name: ' ', email: 'tester@example.com'
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
    end
    it 'nameが50文字以上の場合は無効であること' do
      user = build :user, name: 'a' * 51, email: 'tester@example.com'
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('is too long (maximum is 50 characters)')
    end

    it 'emailが無ければ無効であること' do
      user = build :user, name: 'foo', email: nil
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end
    it 'emailが空文字の場合は無効であること' do
      user = build :user, name: 'foo', email: ''
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end
    it 'emailが空白の場合は無効であること' do
      user = build :user, name: 'foo', email: ' '
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end
    it 'emailが255文字以上の場合は無効であること' do
      user = build :user, name: 'foo', email: 'a' * 244 + '@example.com'
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('is too long (maximum is 255 characters)')
    end
    it "無効なアドレスはemailのバリデーションチェックで無効となること" do
      user = build :user
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar..com foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        expect(user).to be_invalid, "#{invalid_address.inspect} should be invalid"
        expect(user.errors[:email]).to include('is invalid')
      end
    end
    it "重複したメールアドレスは無効であること" do
      create :user, email: 'tester@example.com'
      user = build :user, email: 'tester@example.com'
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('has already been taken')
    end
    it "重複したメールアドレスは大文字小文字を区別せず無効であること" do
      create :user, email: 'tester@example.com'
      user = build :user, email: 'TESTER@EXAMPLE.COM'
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('has already been taken')
    end
    it "パスワードがない場合は無効であること" do
      user = build :user, password: nil, password_confirmation: nil
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end
    it "password should be present (nonblank)" do
      user = build :user, password: " " * 6, password_confirmation: " " * 6
      expect(user).to be_invalid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "password should have a minimum length" do
      user = build :user, password: "a" * 5, password_confirmation: "a" * 5
      expect(user).to be_invalid
      expect(user.errors[:password]).to include('is too short (minimum is 6 characters)')
    end
  end
end
