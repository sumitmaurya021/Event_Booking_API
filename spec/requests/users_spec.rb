require 'rails_helper'

RSpec.describe "Users", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application) }
  let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id, application_id: application.id) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET /users" do
    it "returns a list of users with status code 200" do
      get api_v1_users_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /users" do
    it "creates a new user with status code 201" do
      post api_v1_users_path, params: { user: FactoryBot.attributes_for(:user) }
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /users/:id" do
    it "updates a user with status code 200" do
      put api_v1_user_path(user), params: { user: FactoryBot.attributes_for(:user) }, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /users/:id" do
    it "deletes a user with status code 200" do
      delete api_v1_user_path(user), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /users/:id" do
    it "returns a user with status code 200" do
      get api_v1_user_path(user), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end
end
