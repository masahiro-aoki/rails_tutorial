require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /signup" do
    it "リクエストが正常であること" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'Sign Up | Ruby on Rails Tutorial Sample App'
    end
  end

  describe "GET /create" do
    it "ユーザーが正常に作成されること" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect {
        post users_path, params: { user: { name:  "test user",
                                           email: "user@example.com",
                                           password:              "password",
                                           password_confirmation: "password" } }
      }.to change(User, :count).by(1)
    end
    it "ユーザーが作成されないこと" do
      get signup_path
      expect(response).to have_http_status(:success)
      expect {
        post signup_path, params: { user: { name:  "",
                                           email: "user@invalid",
                                           password:              "foo",
                                           password_confirmation: "bar" } }
      }.to change(User, :count).by(0)
      expect(response.body).to include 'error_explanation'
    end
  end
end
