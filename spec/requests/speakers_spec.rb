require 'rails_helper'

RSpec.describe "Speakers", type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:application) { FactoryBot.create(:oauth_application) }
  let(:access_token) { FactoryBot.create(:access_token, resource_owner_id: user.id, application_id: application.id) }

  before do
    sign_in(user, scope: :user)
  end

  describe "GET /speakers" do
    it "returns a list of speakers with status code 200" do
      get api_v1_speakers_path, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /speakers/:id" do
    let(:speaker) { FactoryBot.create(:speaker) }
    it "returns a single speaker with status code 200" do
      get api_v1_speaker_path(speaker), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "PUT /speakers/:id" do
    let(:speaker) { FactoryBot.create(:speaker) }
    it "updates an speaker with status code 200" do
      updated_speaker_params = FactoryBot.attributes_for(:speaker)
      put api_v1_speaker_path(speaker), params: { speaker: updated_speaker_params }, headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE /speakers/:id" do
    let(:speaker) { FactoryBot.create(:speaker) }
    it "deletes an speaker with status code 200" do
      delete api_v1_speaker_path(speaker), headers: { Authorization: "Bearer #{access_token.token}" }
      expect(response).to have_http_status(200)
    end
  end
end
