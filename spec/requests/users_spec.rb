require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
  end

  describe "GET /users" do
    it 'returns http success' do
      get "/api/v1/users"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it 'get one user in show for api' do
      get api_v1_user_path(1)
      expect(response).to have_http_status(200)
    end
  end

end
