require 'rails_helper'

RSpec.describe "Users", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/signup"
      expect(response).to have_http_status(:success)
      expect(response.body).to include 'Sign Up | Ruby on Rails Tutorial Sample App'
    end
  end

end
