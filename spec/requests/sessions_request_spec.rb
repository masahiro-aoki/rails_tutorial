require 'rails_helper'

RSpec.describe "Sessions", type: :request do

  describe "GET /new" do
    it "リクエストが正常であること" do
      get login_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'Log in | Ruby on Rails Tutorial Sample App'
    end
  end

  describe "POST /create" do
    it "ログイン成功時にプロフィール画面が表示されること" do
      user = create :user
      get login_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'Log in'
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response).to redirect_to "/users/#{user.id}"
    end
    it "ログインに失敗時にログイン画面が表示されること" do
      get login_path
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'Log in'
      post login_path, params: { session: { email: "", password: "" } }
      expect(response.body).to include 'Invalid email/password combination'
      get root_path
      expect(response.body).to_not include 'Invalid email/password combination'
    end
  end

end
