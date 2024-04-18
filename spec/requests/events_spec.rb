require 'rails_helper'

RSpec.describe "Events", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application) }
  let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id, application_id: application.id) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET /events" do
    it "returns a list of events with status code 200" do
      get api_v1_events_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /events" do
    it "creates a new event with status code 201" do
      post api_v1_events_path, headers: { Authorization: "Bearer #{access_token.token}" }, params: { event: FactoryBot.attributes_for(:event) }
      expect(response).to have_http_status(201)
    end
  end

  describe "PUT /events/:id" do
    let(:event) { FactoryBot.create(:event) }
    it "updates an event with status code 200" do
      updated_event_params = FactoryBot.attributes_for(:event)
      put api_v1_event_path(event), params: { event: updated_event_params }, headers: { Authorization: "Bearer #{access_token.token}" }

      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /events/:id" do
    let(:event) { FactoryBot.create(:event) }
    it "deletes an event with status code 204" do
      delete api_v1_event_path(event), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "upcoming_events" do
    it "returns a list of upcoming events with status code 200" do
      get api_v1_upcoming_events_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "search" do
    it "returns a list of events searched with status code 200" do
      get api_v1_search_events_path, params: { event_name: "test", location: "test", date: 2022-01-01 }, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end



end
